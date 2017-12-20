require 'rails_helper'

describe SessionsController, type: :controller do
  let(:user) { create(:user) }

  context 'GET#new' do
    it 'renders the new template' do
      get :new

      expect(response).to render_template :new
    end

    it 'redirects to dashboard path - logged in user' do
      get :new, session: { user_id: user.id }

      expect(response).to redirect_to dashboard_path
    end
  end

  context 'POST#create' do
    it 'redirects to dashboard path - successful log in' do
      post :create, params: { session: { email: user.email, password: 'password' } }

      expect(response).to redirect_to dashboard_path
    end
    it 'renders the new template - unsuccessful log in' do
      post :create, params: { session: { email: user.email, password: 'passwordz' } }

      expect(response).to render_template :new
    end
  end
end
