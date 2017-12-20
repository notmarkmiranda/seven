require 'rails_helper'

describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:attrs) { attributes_for(:user) }

  context 'GET#new' do
    it 'renders the new template - visitor' do
      get :new

      expect(response).to render_template :new
    end

    it 'redirects to the dashboard path - logged in user' do
      get :new, session: { user_id: user.id }

      expect(response).to redirect_to dashboard_path
    end
  end

  context 'POST#create' do
    it 'redirects to the dashboard path - successful create' do
      expect {
        post :create, params: { user: attrs }
      }.to change(User, :count).by 1
      expect(response).to redirect_to dashboard_path
    end

    it 'renders the new template - unsuccessful create' do
      expect {
        post :create, params: { user: attrs.except(:first_name) }
      }.to_not change(User, :count)
      expect(response).to render_template :new
    end
  end

  context 'GET#edit' do
    it 'renders the edit template' do
      get :edit, session: { user_id: user.id }

      expect(response).to render_template :edit
    end
  end

  context 'PATCH#update' do
    it 'redirects to dashboard path - successful update' do
      patch :update, session: { user_id: user.id }, params: { user: attrs }

      expect(response).to redirect_to dashboard_path
    end

    it 'renders the edit template - unsuccessful update' do
      patch :update, session: { user_id: user.id }, params: { user: { first_name: '' } }

      expect(response).to render_template :edit
    end
  end
end
