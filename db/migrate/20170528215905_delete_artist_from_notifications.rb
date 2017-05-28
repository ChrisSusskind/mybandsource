class DeleteArtistFromNotifications < ActiveRecord::Migration[5.0]
  def change
    remove_column :notifications, :receiving_artist_id, :integer
  end
end
