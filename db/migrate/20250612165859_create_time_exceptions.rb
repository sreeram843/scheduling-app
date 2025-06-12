class CreateTimeExceptions < ActiveRecord::Migration[8.0]
  def change
    create_table :time_exceptions do |t|
      t.references :schedule, null: false, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :exception_type, null: false
      t.string :reason
      t.timestamps
    end
  end
end
