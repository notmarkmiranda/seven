class Season < ApplicationRecord
  validates :league_id, presence: true

  belongs_to :league
end
