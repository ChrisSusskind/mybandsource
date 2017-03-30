class AddIndexesToReviewTable < ActiveRecord::Migration[5.0]
  def change
    add_index :reviews, [:user_id, :artist_id], unique: true
    add_index :reviews, :artist_id
    add_index :reviews, :user_id
  end
end
