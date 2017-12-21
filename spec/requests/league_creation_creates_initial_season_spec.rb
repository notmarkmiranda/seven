require 'rails_helper'

describe 'League creation creates an initial season', type: :request do
  let(:user) { create(:user) }
  let(:attrs) { attributes_for(:league) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'changes the count of season' do
    expect {
      post '/leagues', params: { league: attrs }
    }.to change(Season, :count).by(1)
  end
end
