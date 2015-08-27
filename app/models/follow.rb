class Follow < ActiveRecord::Base
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  validates :follower, :followed, presence: true
  validates :follower_id, uniqueness: { scope: [:followed_id] }
end
