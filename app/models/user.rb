class User < ActiveRecord::Base
  has_secure_password
  has_many :workouts
  validates :username, uniqueness: true, presence: true
  validates :password, presence: true
  validates :password, confirmation: {case_sensitive: true}
end