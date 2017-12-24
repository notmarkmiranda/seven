class User < ApplicationRecord
  has_secure_password
  has_secure_token

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :created_leagues, class_name: 'League', foreign_key: 'user_id'
  has_many :user_league_roles
  has_many :leagues, through: :user_league_roles

  def not_admin?(league)
    !admin?(league)
  end

  def admin?(league)
    leagues.merge(UserLeagueRole.admins).include?(league)
  end
end
