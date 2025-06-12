class AddEventAndAppointmentTypeToRecurringAndExceptions < ActiveRecord::Migration[8.0]
  def change
    add_column :recurring_work_hours, :event_type, :string
    add_column :recurring_work_hours, :appointment_type, :string

    add_column :time_exceptions, :event_type, :string
    add_column :time_exceptions, :appointment_type, :string
  end
end
