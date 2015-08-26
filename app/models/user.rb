class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :rememberable, :trackable

  validates :handle, presence: true, uniqueness: true, format: /\A[a-z][a-z0-9]+\z/i
end
