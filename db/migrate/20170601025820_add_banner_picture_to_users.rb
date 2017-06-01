class AddBannerPictureToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :banner_picture, :string
  end
end
