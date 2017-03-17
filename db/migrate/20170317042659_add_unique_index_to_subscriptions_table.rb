class AddUniqueIndexToSubscriptionsTable < ActiveRecord::Migration[5.0]
  def change
    add_index :subscriptions, [:user_id, :artist_id], unique: true
  end
end
