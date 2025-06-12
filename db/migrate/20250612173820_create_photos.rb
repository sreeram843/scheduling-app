class CreatePhotos < ActiveRecord::Migration[8.0]
  def change
    create_table :photos do |t|
      t.references :practitioner, null: false, foreign_key: true
      t.string :url
      t.string :content_type
      t.integer :size
      t.string :file_hash

      t.timestamps
    end
  end
end
