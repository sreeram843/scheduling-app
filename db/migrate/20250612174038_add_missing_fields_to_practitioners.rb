class AddMissingFieldsToPractitioners < ActiveRecord::Migration[8.0]
  def change
    add_column :practitioners, :active, :boolean
    add_column :practitioners, :gender, :string
    add_column :practitioners, :birth_date, :date
    add_column :practitioners, :pronouns, :string
    add_column :practitioners, :status_reason, :string
    add_column :practitioners, :employment_type, :string
    add_column :practitioners, :department, :string
    add_column :practitioners, :nationality, :string
    add_column :practitioners, :extensions, :jsonb
  end
end
