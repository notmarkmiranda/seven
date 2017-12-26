class Game < ApplicationRecord
  validates :date, presence: true
  validates :buy_in, presence: true
  validates :season_id, presence: true

  belongs_to :season
  has_many :players
  delegate :league, to: :season
  delegate :users, to: :league, prefix: true

  def all_possible_players
    league_users.where.not(id: Player.user_ids_by_game(self))
  end

  def full_date
    date.strftime('%B %-e, %Y')
  end

  def no_players?
    players.empty?
  end
end
