class Exercise < ActiveRecord::Base
  belongs_to :user
  belongs_to :workout
  validates :name, :reps, :sets, presence: true
end