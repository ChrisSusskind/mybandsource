class AddPictureToGenres < ActiveRecord::Migration[5.0]
  def change
    add_column :genres, :picture, :string, default: ""
  end
end
