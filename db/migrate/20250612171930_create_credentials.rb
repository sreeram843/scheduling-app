class CreateCredentials < ActiveRecord::Migration[8.0]
  def change
    create_table :credentials do |t|
      t.references :practitioner, null: false, foreign_key: true
      t.string :system
      t.string :value
      t.string :use
      t.string :type

      t.timestamps
    end
  end
end
