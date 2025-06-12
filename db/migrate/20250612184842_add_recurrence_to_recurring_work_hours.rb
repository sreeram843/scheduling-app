class AddRecurrenceToRecurringWorkHours < ActiveRecord::Migration[8.0]
  def change
    add_column :recurring_work_hours, :recurrence_pattern, :string
    add_column :recurring_work_hours, :recurrence_end_date, :date
    add_column :recurring_work_hours, :timezone, :string
  end
end
