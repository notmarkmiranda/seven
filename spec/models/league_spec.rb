require 'rails_helper'

describe League, type: :model do
  context 'validations' do
    context 'uniqueness' do
      before do
        create(:league)
      end

      it { should validate_uniqueness_of :name }
    end

    context 'presence' do
      it { should validate_presence_of :name }
      it { should validate_presence_of :slug }
      it { should validate_presence_of :user_id }
    end
  end

  context 'relationships' do
    it { should belong_to :creator }
    it { should have_many :user_league_roles }
    it { should have_many :users }
    it { should have_many :seasons }
  end

  context 'methods' do
    let!(:league) { create(:league, name: 'marks league') }
    let(:admin) { league.creator }
    let(:user) { create(:user) }
    let(:member) do
      league.grant_membership(user)
      user
    end

    context '#admins' do
      it 'returns admins in an array' do
        expect(league.admins).to match([admin])
      end

      it 'returns a blank array if there are no admins' do
        UserLeagueRole.destroy_all
        expect(league.admins).to eq([])
      end
    end

    context '#grant_adminship' do
      it 'adds a ULR after granting membership' do
        league.grant_adminship(user)
        expect(league.admins).to match_array([admin, user])
      end

      it 'removes an admin after granting membership' do
        league.grant_adminship(member)

        expect(league.members).to eq([])
        expect(league.admins).to match_array([admin, member])
      end
    end

    context '#grant_membership' do
      it 'adds a ULR after granting membership' do
        league.grant_membership(user)
        expect(league.members).to eq([user])
      end

      it 'removes an admin after granting membership' do
        league.grant_membership(admin)

        expect(league.members).to eq([admin])
        expect(league.admins).to eq([])
      end
    end

    context '#members' do
      it 'returns members' do
        member
        expect(league.members).to match([member])
      end

      it 'returns an empty array if there are no members' do
        expect(league.members).to eq([])
      end
    end

    context '#send_invitation' do
      it 'changes the invited attribute' do
        ulr = UserLeagueRole.find_by(league_id: league.id, user_id: member.id)

        expect {
          league.send_invitation(member)
        }.to change { ulr.reload.invited }.from(false).to(true)
      end
    end

    context '#to_param' do
      it 'reuturns slug' do
        expect(league.slug).to eq('marks-league')
      end
    end
  end
end
