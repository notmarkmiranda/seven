require 'rails_helper'

describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  context 'relationships' do
    it { should have_many :created_leagues }
    it { should have_many :user_league_roles }
    it { should have_many :leagues }
    it { should have_many :players }
  end

  context 'methods' do
    let(:league) { create(:league) }
    let(:admin) { league.creator }
    let(:user) { create(:user, first_name: 'Mark', last_name: 'Miranda') }
    let(:member) do
      league.grant_membership(user)
      user
    end

    context '#admin?(league)' do
      it 'returns true' do
        expect(admin.admin?(league)).to be true
      end

      it 'returns false - member' do
        expect(member.admin?(league)).to be false
      end

      it 'returns false - user' do
        expect(user.admin?(league)).to be false
      end
    end

    context '#full_name' do
      it 'returns the full name of a player' do
        expect(user.full_name).to eq('Mark Miranda')
      end
    end

    context 'not_admin?(league)' do
      it 'returns true - member' do
        expect(member.not_admin?(league)).to be true
      end

      it 'returns true - user' do
        expect(user.not_admin?(league)).to be true
      end

      it 'returns false' do
        expect(admin.not_admin?(league)).to be false
      end
    end
  end
end
