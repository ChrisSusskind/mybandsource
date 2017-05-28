class RemoveArtistsAddUserForeignKeysToReviews < ActiveRecord::Migration[5.0]
  def change
    add_reference :reviews, :receiving_user, references: :users, index: true
    add_reference :reviews, :leaving_user, references: :users, index: true
    remove_column :reviews, :artist_id, :integer
    remove_column :reviews, :user_id, :integer
  end
end
