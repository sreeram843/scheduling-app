class RenameTypeInCredentials < ActiveRecord::Migration[8.0]
  def change
    rename_column :credentials, :type, :credential_type
  end
end
