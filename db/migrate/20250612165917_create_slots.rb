class CreateSlots < ActiveRecord::Migration[8.0]
  def change
    create_table :slots do |t|
      t.references :practitioner, null: false, foreign_key: true
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.boolean :available, default: true
      t.string :source_type
      t.bigint :source_id
      t.timestamps
    end

    add_index :slots, [ :practitioner_id, :start_time ], unique: true
  end
end
