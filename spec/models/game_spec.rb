require 'rails_helper'

describe Game, type: :model do
  context 'validations' do
    it { should validate_presence_of :date }
    it { should validate_presence_of :buy_in }
    it { should validate_presence_of :season_id }
  end

  context 'relationships' do
    it { should belong_to :season }
    it { should have_many :players }
  end

  context 'methods' do
    let!(:game)   { create(:game) }
    let(:league) { game.league }
    let(:admin)  { league.creator }
    let(:member) do
      user = create(:user)
      league.grant_membership(user)
      user
    end

    context '#all_possible_players' do
      it 'returns all possible players' do
        member
        expect(game.all_possible_players).to match_array([member, admin])
      end

      it 'returns an empty array' do
        UserLeagueRole.destroy_all
        expect(game.all_possible_players).to match_array([])
      end
    end

    context '#full_date' do
      it 'returns a formatted date' do
        expect(game.full_date).to eq('December 6, 1981')
      end
    end

    context '#no_players?' do
      it 'returns true' do
        expect(game.no_players?).to be true
      end

      it 'returns false' do
        create(:player, game: game)
        expect(game.no_players?).to be false
      end
    end
  end
end
