require 'rails_helper'

describe League, type: :model do
  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :slug }
    it { should validate_presence_of :user_id }
  end

  context 'relationships' do
    it { should belong_to :creator }
    it { should have_many :user_league_roles }
    it { should have_many :users }
    it { should have_many :seasons }
  end

  context 'methods' do
    let(:league) { create(:league, name: 'marks league') }

    context '#to_param' do
      it 'reuturns slug' do
        expect(league.slug).to eq('marks-league')
      end
    end
  end
end
