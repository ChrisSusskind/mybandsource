class ChangeArtistTagColumnNameUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :artist?, :is_artist
  end
end
