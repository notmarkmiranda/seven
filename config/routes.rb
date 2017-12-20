Rails.application.routes.draw do
  resources :users, only: [:index, :show]
  resources :leagues, except: [:delete], param: :slug
  get   '/sign-up', to: 'users#new', as: 'sign_up'
  post  '/sign-up', to: 'users#create'

  get   '/edit-profile', to: 'users#edit', as: 'edit_profile'
  patch '/edit-profile', to: 'users#update'

  get   '/dashboard', to: 'users#show', as: 'dashboard'
end
