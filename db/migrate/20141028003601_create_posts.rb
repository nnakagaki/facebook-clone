class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :author_id, null: false
      t.integer :userwall_id, null: false
      t.text :description, null: false

      t.timestamps
    end

    add_index :posts, :author_id
    add_index :posts, :userwall_id
  end
end
