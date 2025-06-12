class ReplaceRecurrencePatternInRecurringWorkHours < ActiveRecord::Migration[8.0]
  def change
    remove_column :time_exceptions, :recurrence_pattern, :string
    remove_column :time_exceptions, :recurrence_end_date, :date
    add_column :time_exceptions, :recurrence_rules, :jsonb, default: {}, null: false
  end
end
