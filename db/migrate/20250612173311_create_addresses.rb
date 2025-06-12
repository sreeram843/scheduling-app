class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.references :practitioner, null: false, foreign_key: true
      t.string :use
      t.string :type
      t.string :line, array: true, default: []
      t.string :city
      t.string :district
      t.string :state
      t.string :postal_code
      t.string :country

      t.timestamps
    end
  end
end
