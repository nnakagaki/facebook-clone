class AddPicturesViaFilepickerUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_pic_url, :string
    add_column :users, :profile_pic_mini_url, :string
    add_column :users, :cover_pic_url, :string
  end
end
