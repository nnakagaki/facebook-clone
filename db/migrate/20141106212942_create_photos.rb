class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id, null: false
      t.integer :album_id, null: false
      t.text :description
      t.string :url, null: false

      t.timestamps
    end
  end
end
