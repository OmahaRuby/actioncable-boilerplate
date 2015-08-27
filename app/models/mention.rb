class Mention < ActiveRecord::Base
  belongs_to :thought, inverse_of: :mentions
  belongs_to :mentioned, class_name: 'User', inverse_of: :mentions_as_mentioned

  has_one :mentioner, through: :thought, source: :user

  validates :thought, :mentioner, :mentioned, presence: true
end
