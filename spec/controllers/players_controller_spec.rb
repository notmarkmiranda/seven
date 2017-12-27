require 'rails_helper'

describe PlayersController, type: :controller do
  let(:player) { create(:player) }
  let(:game)   { player.game }
  let(:season) { game.season }
  let(:league) { season.league }
  let(:params) { { league_slug: league.slug, season_id: season.id, game_id: game.id } }
  let!(:admin) { league.creator }
  let(:user)   { create(:user) }
  let(:member) do
    league.grant_membership(user)
    user
  end

  context 'GET#index' do
    it 'renders index template' do
      get :index, params: params

      expect(response).to render_template :index
    end
  end

  context 'GET#show' do
    it 'render show template' do
      get :show, params: params.merge(id: player.id)

      expect(response).to render_template :show
    end
  end

  context 'GET#new' do
    context 'as an admin' do
      it 'renders the new template' do
        get :new, session: { user_id: admin.id }, params: params

        expect(response).to render_template :new
      end
    end

    context 'as an non-admin' do
      it 'redirects a visitor to root path' do
        get :new, params: params

        expect(response).to redirect_to root_path
      end

      it 'redirects a user to dashboard path' do
        get :new, session: { user_id: user.id }, params: params

        expect(response).to redirect_to dashboard_path
      end

      it 'redirects a member to dashboard path' do
        get :new, session: { user_id: member.id }, params: params

        expect(response).to redirect_to dashboard_path
      end
    end
  end

  context 'POST#create' do
    let(:attrs) { attributes_for(:player) }
    context 'as an admin' do
      it 'redirects to new league season game player path - successful create' do
        expect {
          post :create, session: { user_id: admin.id }, params: params.merge(player: attrs.merge(user_id: user.id))
        }.to change(Player, :count).by(1)

        expect(response).to redirect_to new_league_season_game_player_path(league, season, game)
      end

      it 'redirects to new league season game player path - unsuccessful create' do
        expect {
          post :create, session: { user_id: admin.id }, params: params.merge(player: attrs)
        }.to_not change(Player, :count)

        expect(response).to redirect_to new_league_season_game_player_path(league, season, game)
      end
    end

    context 'as an non-admin' do
      it 'redirects a visitor to root path' do
        post :create, params: params.merge(player: attrs.merge(user_id: user.id))

        expect(response).to redirect_to root_path
      end

      it 'redirects a user to dashboard path' do
        post :create, session: { user_id: user.id }, params: params.merge(player: attrs.merge(user_id: user.id))

        expect(response).to redirect_to dashboard_path
      end

      it 'redirects a member to dashboard path' do
        post :create, session: { user_id: member.id }, params: params.merge(player: attrs.merge(user_id: user.id))

        expect(response).to redirect_to dashboard_path
      end
    end
  end

  context 'GET#edit' do
    context 'as an admin' do
      it 'renders the edit template' do
        get :edit, session: { user_id: admin.id }, params: params.merge(id: player.id)

        expect(response).to render_template :edit
      end
    end

    context 'as an non-admin' do
      it 'redirects a visitor to root path' do
        get :edit, params: params.merge(id: player.id)

        expect(response).to redirect_to root_path
      end

      it 'redirects a user to dashboard path' do
        get :edit, session: { user_id: user.id }, params: params.merge(id: player.id)

        expect(response).to redirect_to dashboard_path
      end

      it 'redirects a member to dashboard path' do
        get :edit, session: { user_id: member.id }, params: params.merge(id: player.id)

        expect(response).to redirect_to dashboard_path
      end
    end
  end
  context 'PATCH#udpate' do
    context 'as an admin' do
      it 'redirects to player - successful update' do
        patch :update, session: { user_id: admin.id }, params: params.merge(id: player.id, player: { finishing_place: 1 })

        expect(response).to redirect_to league_season_game_player_path(league, season, game, player)
      end

      it 'renders the edit template - unsuccessful update' do
        patch :update, session: { user_id: admin.id }, params: params.merge(id: player.id, player: { game_id: nil })

        expect(response).to render_template :edit
      end
    end
    context 'as an non-admin' do
      it 'redirects visitor to root path' do
        patch :update, params: params.merge(id: player.id, player: { finishing_place: 1 })

        expect(response).to redirect_to root_path
      end

      it 'redirects user to dashboard path' do
        patch :update, session: { user_id: user.id }, params: params.merge(id: player.id, player: { finishing_place: 1 })

        expect(response).to redirect_to dashboard_path
      end

      it 'redirects member to dashboard path' do
        patch :update, session: { user_id: member.id }, params: params.merge(id: player.id, player: { finishing_place: 1 })

        expect(response).to redirect_to dashboard_path
      end
    end
  end
end
