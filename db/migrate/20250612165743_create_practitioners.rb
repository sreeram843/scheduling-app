class CreatePractitioners < ActiveRecord::Migration[8.0]
  def change
    create_table :practitioners do |t|
      t.boolean :active
      t.string :gender
      t.date :birth_date
      t.string :pronouns
      t.string :status_reason
      t.string :employment_type
      t.string :department
      t.string :nationality
      t.jsonb :extensions

      t.timestamps
    end
  end
end
