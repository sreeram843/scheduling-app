# app/models/recurring_work_hour.rb
class RecurringWorkHour < ApplicationRecord
  belongs_to :schedule

  store_accessor :recurrence_rules, :frequency, :interval, :days_of_week, :repeat_until

  validates :frequency, inclusion: { in: %w[daily weekly monthly], allow_blank: true }
  validates :weekday, presence: true, inclusion: { in: 0..6 }
  validates :start_time, :end_time, :timezone, presence: true
  validate :end_time_after_start_time
  validate :no_duplicate_pattern_for_same_day

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?
    errors.add(:end_time, "must be after start time") if end_time <= start_time
  end

  def no_duplicate_pattern_for_same_day
    return unless schedule

    duplicates = RecurringWorkHour
      .where(schedule_id: schedule_id, weekday: weekday, start_time: start_time, end_time: end_time)
      .where.not(id: id)

    if duplicates.exists?
      errors.add(:base, "Duplicate recurring work hour for same weekday and time range")
    end
  end
end
