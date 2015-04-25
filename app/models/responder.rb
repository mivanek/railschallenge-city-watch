class Responder < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true
  validates :type, presence: true
  validates :capacity, presence: true
  validates :capacity, inclusion: { in: (1..5) }
end
