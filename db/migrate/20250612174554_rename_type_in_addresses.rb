class RenameTypeInAddresses < ActiveRecord::Migration[8.0]
  def change
    rename_column :addresses, :type, :address_type
  end
end
