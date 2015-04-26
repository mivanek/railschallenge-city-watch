class Responder < ActiveRecord::Base
  has_one :emergency_responder
  has_one :emergency, through: :emergency_responder

  validates :name, uniqueness: true, presence: true
  validates :type, presence: true
  validates :capacity, presence: true, inclusion: { in: (1..5) }

  scope :fire, -> { where(type: 'Fire') }
  scope :police, -> { where(type: 'Police') }
  scope :medical, -> { where(type: 'Medical') }
  scope :on_duty, -> { where(on_duty: true) }

  def self.responder_statistics
    [
      sum(:capacity), available.sum(:capacity),
      on_duty.sum(:capacity), on_duty.available.sum(:capacity)
    ]
  end

  def self.available
    where.not(id: Emergency.unresolved.joins(:emergency_responders).pluck(:responder_id))
  end
end
