# app/models/time_exception.rb
class TimeException < ApplicationRecord
  belongs_to :schedule

  store_accessor :recurrence_rules, :frequency, :interval, :days_of_week, :repeat_until

  validates :start_time, :end_time, :exception_type, :timezone, presence: true
  validate :end_time_after_start_time
  validate :within_schedule_range
  validate :no_conflicts_with_schedule

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?
    errors.add(:end_time, "must be after start time") if end_time <= start_time
  end

  def within_schedule_range
    return unless schedule && schedule.start_date && schedule.end_date

    if start_time.to_date < schedule.start_date || end_time.to_date > schedule.end_date
      errors.add(:base, "Time exception must be within schedule's date range")
    end
  end

  def no_conflicts_with_schedule
    return unless schedule

    overlaps = TimeException
      .where(schedule_id: schedule_id)
      .where.not(id: id)
      .where("start_time < ? AND end_time > ?", end_time, start_time)

    if overlaps.exists?
      errors.add(:base, "Time exception overlaps with an existing exception")
    end
  end
end
