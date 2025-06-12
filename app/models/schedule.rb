# app/models/schedule.rb
class Schedule < ApplicationRecord
  belongs_to :practitioner
  has_many :recurring_work_hours, dependent: :destroy
  has_many :time_exceptions, dependent: :destroy

  validates :category, presence: true
  validates :event_type, inclusion: {
    in: %w[extra_working_hours personal_event holiday administrative_block],
    allow_blank: true
  }
  validates :appointment_type, inclusion: {
    in: %w[initial ongoing flex],
    allow_blank: true
  }
  validates :start_date, :end_date, :timezone, presence: true
  validate :end_date_after_start_date
  validate :no_conflict_with_existing_schedules

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    errors.add(:end_date, "must be after the start date") if end_date < start_date
  end

  def no_conflict_with_existing_schedules
    return unless practitioner

    overlapping = Schedule
      .where(practitioner_id: practitioner_id)
      .where.not(id: id)
      .where("start_date <= ? AND end_date >= ?", end_date, start_date)

    overlapping.each do |other|
      if availability? && other.unavailability?
        errors.add(:base, "Conflicts with an unavailable schedule: #{other.event_type}")
      elsif unavailability? && other.availability?
        errors.add(:base, "Conflicts with an available schedule: #{other.event_type}")
      end
    end
  end

  def availability?
    event_type == "extra_working_hours"
  end

  def unavailability?
    %w[holiday personal_event administrative_block].include?(event_type)
  end
end
