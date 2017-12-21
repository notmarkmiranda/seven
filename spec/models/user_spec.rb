require 'rails_helper'

describe User, type: :model do
  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  context 'relationships' do
    it { should have_many :created_leagues }
    it { should have_many :user_league_roles }
    it { should have_many :leagues }
  end

  context 'methods'
end
