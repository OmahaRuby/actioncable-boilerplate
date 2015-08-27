class Thought < ActiveRecord::Base
  MENTION_MATCHER = /~([a-z][a-z0-9]+)/i

  belongs_to :user, inverse_of: :thoughts

  has_many :mentions, inverse_of: :thought

  validates :user, :message, presence: true
  validates :message, length: { maximum: 128 }

  validate :message_has_not_changed, unless: :new_record?

  after_save :enumerate_mentions!, on: [:create]

  private

  def message_has_not_changed
    errors.add(:message, 'cannot be changed') if message_changed?
  end

  def enumerate_mentions!
    message.scan(/~([a-z][a-z0-9]+)/i).each do |handle|
      user = User.find_by(handle: handle)

      mentions << Mention.new(mentioned: user) if user
    end
  end
end
