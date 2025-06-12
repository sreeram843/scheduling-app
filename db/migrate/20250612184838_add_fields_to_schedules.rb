class AddFieldsToSchedules < ActiveRecord::Migration[8.0]
  def change
    add_column :schedules, :event_type, :string
    add_column :schedules, :appointment_type, :string
    add_column :schedules, :start_time, :datetime
    add_column :schedules, :end_time, :datetime
    add_column :schedules, :timezone, :string
  end
end
