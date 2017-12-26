class User < ApplicationRecord
  has_secure_password
  has_secure_token

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :created_leagues, class_name: 'League', foreign_key: 'user_id'
  has_many :user_league_roles
  has_many :leagues, through: :user_league_roles
  has_many :players

  def admin?(league)
    leagues.merge(UserLeagueRole.admins).include?(league)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def not_admin?(league)
    !admin?(league)
  end
end
