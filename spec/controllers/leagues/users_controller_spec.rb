require 'rails_helper'

describe Leagues::UsersController, type: :controller do
  let!(:game)   { create(:game) }
  let(:season) { game.season }
  let(:league) { game.league }
  let(:admin)  { league.creator }
  let(:user)   { create(:user) }
  let(:member) do
    league.grant_membership(user)
    user
  end

  let(:other_admin) do
    league.grant_adminship(user)
    user
  end

  context 'GET#new' do
    it 'renders the new template - admin' do
      get :new, session: { user_id: admin.id }, params: { league_slug: league.slug }

      expect(response).to render_template :new
    end

    it 'renders the new template - other admin' do
      get :new, session: { user_id: other_admin.id }, params: { league_slug: league.slug }

      expect(response).to render_template :new
    end

    it 'redirects visitor to root path' do
      get :new, params: { league_slug: league.slug }

      expect(response).to redirect_to root_path
    end

    it 'redirects user to dashboard path' do
      get :new, session: { user_id: user.id }, params: { league_slug: league.slug }

      expect(response).to redirect_to dashboard_path
    end
    it 'redirects member to dashboard path' do
      get :new, session: { user_id: member.id }, params: { league_slug: league.slug }

      expect(response).to redirect_to dashboard_path
    end
  end

  context 'POST#create' do
    let(:params) {
      {
        save_and_finish: 'yes',
        league_slug: league.slug,
        user: {
          email: 'test@example.com',
          first_name: 'jacob',
          last_name: 'jingleheimer-schmidt',
          user_league_role: {
            invited: '1',
            admin: '0'
          },
          player: {
            additional_expense: '75'
          }
        }
      }
    }

    it 'redirects to new league season game player path and changes the count of users, players, and ulrs - admin' do
      expect {
        post :create, session: { user_id: admin.id, game_id: game.id}, params: params
      }.to change(User, :count).by(1)
        .and change(UserLeagueRole, :count).by(1)
        .and change(Player, :count).by(1)
      expect(response).to redirect_to new_league_season_game_player_path(league, season, game)
    end

    it 'redirects to new league season game player path and changes the count of users, players, and ulrs - other admin' do
      other_admin

      expect {
        post :create, session: { user_id: other_admin.id, game_id: game.id}, params: params
      }.to change(User, :count).by(1)
        .and change(UserLeagueRole, :count).by(1)
        .and change(Player, :count).by(1)
      expect(response).to redirect_to new_league_season_game_player_path(league, season, game)
    end
  end
end
