Rails.application.routes.draw do
  mount ActionCable.server, at: '/action_cable'

  devise_for :users

  scope '/~:handle', constraints: { handle: /[a-z][a-z0-9]+/i } do
    get '/', to: 'users#show', as: 'user'
    get '/followers', to: 'users#followers', as: 'user_followers'
    get '/following', to: 'users#following', as: 'user_following'
  end

  resources :thoughts, only: [:create, :index]
  resources :follows, only: [:create, :destroy]
  resources :users, only: [:index]

  root to: 'thoughts#index'
end
