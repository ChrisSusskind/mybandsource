class DropArtists < ActiveRecord::Migration[5.0]
  def change
    drop_table :artists
  end
end
