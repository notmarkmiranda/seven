Rails.application.routes.draw do
  root 'pages#index'
  resources :users, only: [:index, :show]
  resources :leagues, except: [:delete], param: :slug

  get   '/sign-up', to: 'users#new', as: 'sign_up'
  post  '/sign-up', to: 'users#create'
  get   '/sign-in', to: 'sessions#new', as: 'sign_in'
  post  '/sign-in', to: 'sessions#create'
  get   '/sign-out', to: 'sessions#destroy', as: 'sign_out'

  get   '/edit-profile', to: 'users#edit', as: 'edit_profile'
  patch '/edit-profile', to: 'users#update'

  get   '/dashboard', to: 'users#show', as: 'dashboard'
end
