class Exercise < ActiveRecord::Base
  belongs_to :user
  belongs_to :workout
  validates :name, presence: true
  validates :reps, :sets, presence: true, numericality: { greater_than_or_equal_to: 0 }
end