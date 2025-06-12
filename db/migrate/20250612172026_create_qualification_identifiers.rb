class CreateQualificationIdentifiers < ActiveRecord::Migration[8.0]
  def change
    create_table :qualification_identifiers do |t|
      t.references :qualification, null: false, foreign_key: true
      t.string :system
      t.string :value

      t.timestamps
    end
  end
end
