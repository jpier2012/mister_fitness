class Template < ActiveRecord::Base
  has_many :exercises
  validates :name, uniqueness: true, presence: true
end