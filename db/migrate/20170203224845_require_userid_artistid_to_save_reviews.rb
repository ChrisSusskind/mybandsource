class RequireUseridArtistidToSaveReviews < ActiveRecord::Migration[5.0]
  def self.up
    change_column :reviews, :user_id, :integer, null: false
    change_column :reviews, :artist_id, :integer, null: false
  end

  def self.down
    change_column :reviews, :user_id, :integer
    change_column :reviews, :artist_id, :integer
  end
end
