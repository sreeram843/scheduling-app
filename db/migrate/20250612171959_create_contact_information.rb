class CreateContactInformation < ActiveRecord::Migration[8.0]
  def change
    create_table :contact_informations do |t|
      t.references :practitioner, null: false, foreign_key: true
      t.string :system
      t.string :value
      t.string :use
      t.integer :rank

      t.timestamps
    end
  end
end
