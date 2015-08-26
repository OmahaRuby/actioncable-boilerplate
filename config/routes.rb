Rails.application.routes.draw do
  mount ActionCable.server, at: '/action_cable'

  devise_for :users

  root to: 'static_pages#landing'
end
