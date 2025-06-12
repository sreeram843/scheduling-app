class CreateQualifications < ActiveRecord::Migration[8.0]
  def change
    create_table :qualifications do |t|
      t.references :practitioner, null: false, foreign_key: true
      t.string :code
      t.date :start_date
      t.date :end_date
      t.string :issuer_name

      t.timestamps
    end
  end
end
