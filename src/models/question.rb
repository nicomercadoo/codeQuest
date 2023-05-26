class Question < ActiveRecord::Base
  validates :number, presence: true
  validates :description, presence: true
  validates :well_answered, presence: true
  belongs_to :test
  has_many :options
end
