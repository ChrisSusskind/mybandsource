class AddGenreIdToArtists < ActiveRecord::Migration[5.0]
  def change
    add_column :artists, :genre_id, :integer
    add_index :artists, :genre_id
  end
end
