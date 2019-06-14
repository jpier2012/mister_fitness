class Workout < ActiveRecord::Base
  belongs_to :user
  validates :name, uniqueness: true
  validates :name, :description, :instructions, presence: true
end