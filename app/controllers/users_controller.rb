class UsersController < ApplicationController
  def index
    render :index, locals: { users: users }
  end

  def show
    render :show, locals: { user: user }
  end

  def followers
    render :followers, locals: { user: user, users: user.followers }
  end

  def following
    render :following, locals: { user: user, users: user.following }
  end

  private

  def user
    User.find_by!(handle: params[:handle])
  end

  def users
    User.all
  end
end