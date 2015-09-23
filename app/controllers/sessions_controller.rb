class SessionsController < Devise::SessionsController
  def destroy
    ActionCable.server.disconnect(
      current_user: current_user,
      session_id: session_id
    )

    super
  end

  private

  def session_id
    session[:session_id]
  end
end