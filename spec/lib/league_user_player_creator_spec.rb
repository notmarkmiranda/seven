require 'rails_helper'

describe LeagueUserPlayerCreator do
  let(:user) { build(:user) }
  let(:game)   { create(:game) }
  let(:league) { game.league }
  let(:ulr_params) {
    {
      invited: '1',
      admin: '0'
    }
  }
  let(:player_params) {
    {
      additional_expense: '75'
    }
  }
  let(:params) {
    {
      user_league_role: ulr_params,
      player: player_params
    }
  }
  let(:instance) { described_class.new(user: user, league: league, params: params, game_id: game.id, save_and_finish: 'true') }
  context '#initialize' do

    it 'has attributes' do
      expect(instance.user).to eq(user)
      expect(instance.league).to eq(league)
      expect(instance.ulr_params).to eq(ulr_params)
      expect(instance.player_params).to eq(player_params)
      expect(instance.save_and_finish).to_not be nil
      expect(instance.game).to eq(game)
    end
  end

  context '#save' do
    it 'returns true' do
      expect(instance.save).to be true
    end

    it 'returns false' do
      new_user = build(:user)
      new_user.first_name = nil
      instance.user = new_user

      expect(instance.save).to be false
    end
  end
end
