class League < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true
  validates :user_id, presence: true

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
end
