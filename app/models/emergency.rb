class Emergency < ActiveRecord::Base
  validates :fire_severity, presence: true
  validates :medical_severity, presence: true
  validates :police_severity, presence: true

  validates :fire_severity, numericality: { greater_than_or_equal_to: 0 }
  validates :medical_severity, numericality: { greater_than_or_equal_to: 0 }
  validates :police_severity, numericality: { greater_than_or_equal_to: 0 }

  validates :code, presence: true
  validates :code, uniqueness: true

  scope :resolved, -> { where.not(resolved_at: nil) }
  scope :unresolved, -> { where(resolved_at: nil) }
end
