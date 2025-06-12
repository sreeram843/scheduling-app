class CreateRecurringWorkHours < ActiveRecord::Migration[8.0]
  def change
    create_table :recurring_work_hours do |t|
      t.references :schedule, null: false, foreign_key: true
      t.integer :weekday, null: false
      t.time :start_time, null: false
      t.time :end_time, null: false
      t.timestamps
    end
  end
end
