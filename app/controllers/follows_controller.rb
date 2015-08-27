class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    follow = current_user.follows_as_follower.new follow_params

    unless follow.save
      flash[:error] = follow.errors.full_messages.to_sentence
    end

    redirect_to :back
  end

  def destroy
    follow = current_user.follows_as_follower.find(params[:id])

    follow.destroy

    redirect_to :back
  end

  private

  def follow_params
    params.require(:follow).permit(:followed_id)
  end
end