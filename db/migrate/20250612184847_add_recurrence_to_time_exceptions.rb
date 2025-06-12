class AddRecurrenceToTimeExceptions < ActiveRecord::Migration[8.0]
  def change
    add_column :time_exceptions, :recurrence_pattern, :string
    add_column :time_exceptions, :recurrence_end_date, :date
    add_column :time_exceptions, :timezone, :string
  end
end
