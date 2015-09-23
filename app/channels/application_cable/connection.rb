module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user, :session_id

    def connect
      authenticate_user
    end

    private

    def warden
      request.env['warden']
    end

    def session
      request.session
    end

    def authenticate_user
      self.session_id = session[:session_id]
      self.current_user = warden.authenticate(scope: :user)
    end
  end
end
