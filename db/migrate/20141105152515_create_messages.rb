class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id, null: false
      t.text :message, null: false
      t.string :chat_id, null: false
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
