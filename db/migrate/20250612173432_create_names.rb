class CreateNames < ActiveRecord::Migration[8.0]
  def change
    create_table :names do |t|
      t.references :practitioner, null: false, foreign_key: true
      t.string :use
      t.string :prefix, array: true, default: []
      t.string :given, array: true, default: []
      t.string :suffix, array: true, default: []
      t.string :family,
      t.timestamps
    end
  end
end
