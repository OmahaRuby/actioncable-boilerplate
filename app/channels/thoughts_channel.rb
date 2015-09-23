class ThoughtsChannel < ApplicationCable::Channel
  def stream_thoughts(message)
    scope = message["scope"] || 'all'

    if scope == 'all'
      stream_from 'thoughts'
    elsif scope.start_with?('related-to-')
      stream_from "thoughts:#{scope}"
    elsif scope == 'from_followers'
      stream_from "thoughts:from-followed-by-#{current_user.id}"
    end
  end
end
