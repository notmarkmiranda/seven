class Game < ApplicationRecord
  validates :date, presence: true
  validates :buy_in, presence: true
  validates :season_id, presence: true

  belongs_to :season

  def full_date
    date.strftime('%B %-e, %Y')
  end
end
