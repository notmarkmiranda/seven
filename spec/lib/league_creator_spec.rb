require 'rails_helper'

describe LeagueCreator do
  let(:valid_league) { build(:league) }
  let(:invalid_league) { build(:league, name: '') }

  context '#save' do

    it 'returns true' do
      expect(described_class.new(valid_league).save).to be true
    end

    it 'returns false' do
      expect(described_class.new(invalid_league).save).to be false
    end
  end
end
