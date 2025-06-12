class CreateSchedules < ActiveRecord::Migration[8.0]
    def change
      create_table :schedules do |t|
        t.references :practitioner, null: false, foreign_key: true
        t.string :category, null: false
        t.date :start_date
        t.date :end_date
        t.boolean :enabled, default: true
        t.timestamps
      end
    end
end
