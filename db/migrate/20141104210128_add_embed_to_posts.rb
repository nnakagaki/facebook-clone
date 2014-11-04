class AddEmbedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :embed, :text
  end
end
