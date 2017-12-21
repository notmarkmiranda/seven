require 'rails_helper'

describe SeasonsController, type: :controller do
  let!(:season) { create(:season, :active) }
  let(:league) { season.league }
  let(:admin) { league.creator }
  let(:attrs) { attributes_for(:season, :active) }

  context 'POST#create' do
    it 'redirects to season path - successful create' do
      post :create, session: { user_id: admin.id }, params: { league_slug: league.slug, season: attrs }

      expect(response).to redirect_to league_season_path(league, Season.last)
    end
  end

  context 'PATCH#update' do
    it 'redirects to season path - successful update' do
      patch :update, session: { user_id: admin.id }, params: { league_slug: league.slug, id: season.id, season: { active: false } }

      expect(response).to redirect_to league_season_path(league, Season.last)
    end
  end
end
