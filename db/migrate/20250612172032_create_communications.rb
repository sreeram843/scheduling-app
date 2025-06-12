class CreateCommunications < ActiveRecord::Migration[8.0]
  def change
    create_table :communications do |t|
      t.references :practitioner, null: false, foreign_key: true
      t.string :language_code
      t.boolean :preferred

      t.timestamps
    end
  end
end
