require 'rails_helper'

describe 'League creation creates Admin UserLeagueRole', type: :request do
  let(:user) { create(:user) }
  let(:attrs) { attributes_for(:league) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'changes the count of UserLeagueRole' do
    expect {
      post '/leagues', params: { league: attrs }
    }.to change(UserLeagueRole, :count).by(1)
  end
end
