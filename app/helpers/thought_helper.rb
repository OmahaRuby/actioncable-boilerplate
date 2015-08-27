module ThoughtHelper
  def annotate_mentions(message)
    html_escape(message).gsub(Thought::MENTION_MATCHER) do |match|
      handle = Thought::MENTION_MATCHER.match(match)[1]

      link_to match, user_path(handle)
    end.html_safe
  end
end