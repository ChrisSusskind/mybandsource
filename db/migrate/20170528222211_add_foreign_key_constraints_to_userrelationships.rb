class AddForeignKeyConstraintsToUserrelationships < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :user_relationships, :users, column: :follower_id
    add_foreign_key :user_relationships, :users, column: :followed_id
  end
end
