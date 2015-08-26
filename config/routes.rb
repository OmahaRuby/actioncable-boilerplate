Rails.application.routes.draw do
  mount ActionCable.server, at: '/action_cable'

end
