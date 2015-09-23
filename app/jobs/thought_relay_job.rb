class ThoughtRelayJob < ApplicationJob
  include RenderAnywhere

  def perform(thought)
    thought_partial = render(partial: 'thoughts/thought', locals: { thought: thought })

    message = {
      thought_id: thought.id,
      rendered_thought_partial: thought_partial
    }

    ActionCable.server.broadcast 'thoughts', message

    ActionCable.server.broadcast "thoughts:related-to-#{thought.user_id}", message

    thought.mentioned_user_ids.each do |mentioned_user_id|
      ActionCable.server.broadcast "thoughts:related-to-#{mentioned_user_id}", message
    end

    thought.user.follower_ids.each do |follower_id|
      ActionCable.server.broadcast "thoughts:from-followed-by-#{mentioned_user_id}", message
    end
  end

  private

  def rendering_controller
    @rendering_controller ||= ThoughtsController.new
  end
end