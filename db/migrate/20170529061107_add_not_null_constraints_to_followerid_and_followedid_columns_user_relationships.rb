class AddNotNullConstraintsToFolloweridAndFollowedidColumnsUserRelationships < ActiveRecord::Migration[5.0]
  def self.up
    change_column :user_relationships, :follower_id, :integer, null: false
    change_column :user_relationships, :followed_id, :integer, null: false
  end

  def self.down
    change_column :user_relationships, :follower_id, :integer, null: true
    change_column :user_relationships, :followed_id, :integer, null: true
  end
end
