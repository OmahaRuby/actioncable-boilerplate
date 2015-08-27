class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :trackable

  has_many :thoughts, inverse_of: :user, dependent: :destroy

  has_many :mentions_as_mentioned, class_name: 'Mention', foreign_key: :mentioned_id, inverse_of: :mentioned, dependent: :destroy
  has_many :mentioners, through: :mentions_as_mentioned

  has_many :mentions, class_name: 'Thought', through: :mentions_as_mentioned, source: :thought

  has_many :mentions_as_mentioner, through: :thoughts, source: :mentions, dependent: :destroy
  has_many :mentioned_users, through: :mentions_as_mentioned, source: :mentioned

  has_many :follows_as_followed, class_name: 'Follow', foreign_key: :followed_id, inverse_of: :followed, dependent: :destroy
  has_many :followers, through: :follows_as_followed

  has_many :follows_as_follower, class_name: 'Follow', foreign_key: :follower_id, inverse_of: :follower, dependent: :destroy
  has_many :following, through: :follows_as_follower, source: :followed

  validates :handle, presence: true, uniqueness: true, format: /\A[a-z][a-z0-9]+\z/i

  def related_thoughts
    thought_id = Thought.arel_table[:id]

    Thought.where(
      thought_id.in(
        Arel.sql(thoughts.select(:id).to_sql)
      ).or(
        thought_id.in(
          Arel.sql(mentions.select(:id).to_sql)
        )
      )
    ).uniq
  end

  def is_following?(user)
    following.where(id: user.id).exists?
  end
end
