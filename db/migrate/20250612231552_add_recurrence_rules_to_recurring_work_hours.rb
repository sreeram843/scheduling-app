class AddRecurrenceRulesToRecurringWorkHours < ActiveRecord::Migration[8.0]
  def change
    add_column :recurring_work_hours, :recurrence_rules, :jsonb
  end
end
