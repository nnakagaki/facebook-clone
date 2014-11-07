class CreatePhotoPostAssociation < ActiveRecord::Migration
  def change
    add_column :posts, :photo_id, :integer
    add_column :photos, :post_id, :integer
    remove_column :photos, :description

    Photo.all.each do |photo|
      photo.destroy
    end
  end
end
