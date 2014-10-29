class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.integer :author_id, null: false
      t.integer :post_id, null: false
      t.integer :notifyable_id, null: false
      t.string :notifyable_type, null: false
      t.boolean :seen, default: false

      t.timestamps
    end
  end
end
