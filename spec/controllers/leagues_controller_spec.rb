require 'rails_helper'

describe LeaguesController, type: :controller do
  let(:user) { create(:user) }
  let(:league) { create(:league) }
  let(:admin) { league.creator }
  let(:attrs) { attributes_for(:league) }

  context 'GET#index' do
    it 'renders the index template' do
      get :index

      expect(response).to render_template :index
    end
  end

  context 'GET#show' do
    it 'renders the show template' do
      get :show, params: { slug: league.slug }

      expect(response).to render_template :show
    end
  end

  context 'GET#new' do
    it 'renders the new template - logged in user' do
      get :new, session: { user_id: user.id }

      expect(response).to render_template :new
    end

    it 'redirects a visitor to the sign in path' do
      get :new

      expect(response).to redirect_to sign_in_path
    end
  end

  context 'POST#create' do
    it 'redirects to league_path - successful create' do
      expect {
        post :create, session: { user_id: user.id }, params: { league: attrs }
      }.to change(League, :count).by(1)
      expect(response).to redirect_to league_path(League.last)
    end

    it 'renders the new template - unsuccessful create' do
      post :create, session: { user_id: user.id }, params: { league: attrs.except(:name) }

      expect(response).to render_template :new
    end

    it 'redirects a visitor to the sign in path' do
      post :create, params: { league: attrs.except(:name) }

      expect(response).to redirect_to sign_in_path
    end
  end

  context 'GET#edit' do
    it 'renders the edit template - admin' do
      get :edit, session: { user_id: admin.id }, params: { slug: league.slug }

      expect(response).to render_template :edit
    end

    it 'redirects a visitor to the sign in path' do
      get :edit, params: { slug: league.slug }

      expect(response).to redirect_to sign_in_path
    end

    it 'redirects a non-admin to the dashboard path'
  end

  context 'PATCH#update' do
    it 'redirects to the league path - successful update' do
      patch :update, session: { user_id: admin.id }, params: { slug: league.slug, league: attrs }

      expect(response).to redirect_to league_path(league.reload)
    end

    it 'renders the edit template - unsuccessful update' do
      patch :update, session: { user_id: admin.id }, params: { slug: league.slug, league: { name: '' } }

      expect(response).to render_template :edit
    end

    it 'redirects a visitor to the sign up path' do
      patch :update, params: { slug: league.slug, league: { name: '' } }

      expect(response).to redirect_to sign_in_path
    end

    it 'redirects a non-admin to the dashboard path'
  end
end
