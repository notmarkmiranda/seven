require 'rails_helper'

describe GamesController, type: :controller do
  let!(:game) { create(:game) }
  let(:season) { game.season }
  let(:league) { season.league }
  let(:admin) { league.creator }
  let(:user) { create(:user) }
  let(:member) do
    league.grant_membership(user)
    user
  end

  context 'GET#index' do
    it 'renders the index template' do
      get :index, params: { league_slug: league.slug, season_id: season.id }

      expect(response).to render_template :index
    end
  end

  context 'GET#show' do
    it 'renders the show template' do
      get :show, params: { league_slug: league.slug, season_id: season.id, id: game.id }

      expect(response).to render_template :show
    end
  end

  context 'GET#new' do
    it 'renders the new template - admin' do
      stub_current_user(admin)
      get :new, params: { league_slug: league.slug, season_id: season.id }

      expect(response).to render_template :new
    end

    it 'redirects to dashboard path - member' do
      stub_current_user(member)
      get :new, params: { league_slug: league.slug, season_id: season.id }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to dashboard path - user' do
      stub_current_user(user)
      get :new, params: { league_slug: league.slug, season_id: season.id }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to sign in path - visitor' do
      get :new, params: { league_slug: league.slug, season_id: season.id }

      expect(response).to redirect_to root_path
    end
  end

  context 'POST#create' do
    let(:attrs) { attributes_for(:game) }

    it 'redirects to game - admin / successful create' do
      expect {
        post :create, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id, game: attrs }
      }.to change(Game, :count).by(1)

      expect(response).to redirect_to league_season_game_path(league, season, Game.last)
    end

    it 'renders the new template - admin / unsuccessful create' do
      expect {
        post :create, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id, game: attrs.except(:date) }
      }.to_not change(Game, :count)


      expect(response).to render_template :new
    end

    it 'redirects to dashboard path - user' do
      post :create, session: { user_id: user.id }, params: { league_slug: league.slug, season_id: season.id, game: attrs }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to dashboard path - member' do
      post :create, session: { user_id: member.id }, params: { league_slug: league.slug, season_id: season.id, game: attrs }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to root path - visitor' do
      post :create, params: { league_slug: league.slug, season_id: season.id, game: attrs }

      expect(response).to redirect_to root_path
    end
  end

  context 'GET#edit' do
    it 'renders edit template - admin' do
      get :edit, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id }

      expect(response).to render_template :edit
    end

    it 'redirects to dashboard path - user' do
      get :edit, session: { user_id: user.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to dashboard path - member' do
      get :edit, session: { user_id: member.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to root path - visitor' do
      get :edit, params: { league_slug: league.slug, season_id: season.id, id: game.id }

      expect(response).to redirect_to root_path
    end
  end

  context 'PATCH#update' do
    it 'redirects to game - admin / successful update' do
      patch :update, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id, game: { date: Date.new(2017, 12, 31) } }

      expect(response).to redirect_to league_season_game_path(league, season, game)
    end

    it 'renders new - admin / unsuccessful update' do
      patch :update, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id, game: { date: '' } }

      expect(response).to render_template :new
    end

    it 'redirects to dashboard - member' do
      patch :update, session: { user_id: member.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id, game: { date: Date.new(2017, 12, 31) } }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to dashboard - user' do
      patch :update, session: { user_id: user.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id, game: { date: Date.new(2017, 12, 31) } }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to root - visitor' do
      patch :update, params: { league_slug: league.slug, season_id: season.id, id: game.id, game: { date: Date.new(2017, 12, 31) } }

      expect(response).to redirect_to root_path
    end
  end
end
