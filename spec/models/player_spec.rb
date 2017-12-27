require 'rails_helper'

describe Player, type: :model do
  context 'validations' do
    it { should validate_presence_of :game_id }
    it { should validate_presence_of :user_id }
    it do
      create(:player)
      should validate_uniqueness_of(:game_id).scoped_to(:user_id)
    end
  end

  context 'relationships' do
    it { should belong_to :game }
    it { should belong_to :user }
  end

  context 'methods' do
    let(:game) { create(:game) }

    context 'self#user_ids_by_game' do
      it 'returns an empty array' do
        expect(Player.user_ids_by_game(game)).to eq([])
      end

      it 'returns an array of users' do
        pl = create(:player, game: game)
        player_array = Player.user_ids_by_game(game)
        player = player_array.first

        expect(player.user_id).to eq(pl.user_id)
        expect(player.class).to eq(Player)
      end
    end
  end
end
