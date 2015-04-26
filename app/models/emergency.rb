class Emergency < ActiveRecord::Base
  has_many :emergency_responders
  has_many :responders, through: :emergency_responders

  validates :fire_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :medical_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :police_severity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :code, presence: true, uniqueness: true

  scope :resolved, -> { where.not(resolved_at: nil) }
  scope :unresolved, -> { where(resolved_at: nil) }

  def full_response?
    return true if responders.sum(:capacity) == total_severity
    false
  end

  def total_severity
    fire_severity + medical_severity + police_severity
  end

  def self.full_response_count
    all.select(&:full_response?).count
  end
end
