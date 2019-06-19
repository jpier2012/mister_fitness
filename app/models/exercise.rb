class Exercise < ActiveRecord::Base
  belongs_to :workout
  validates :name, presence: true
end