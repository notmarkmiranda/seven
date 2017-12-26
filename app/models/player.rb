class Player < ApplicationRecord
  validates :game_id, presence: true, uniqueness: { scope: :user_id }
  validates :user_id, presence: true

  belongs_to :game
  belongs_to :user
  delegate :full_name, to: :user, prefix: true

  def self.user_ids_by_game(game)
    select(:user_id).where(game_id: game)
  end
end
