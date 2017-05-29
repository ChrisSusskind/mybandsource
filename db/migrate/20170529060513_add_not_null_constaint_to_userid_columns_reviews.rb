class AddNotNullConstaintToUseridColumnsReviews < ActiveRecord::Migration[5.0]
  def self.up
    change_column :reviews, :leaving_user_id, :integer, null: false
    change_column :reviews, :receiving_user_id, :integer, null: false
  end

  def self.down
    change_column :reviews, :leaving_user_id, :integer, null: true
    change_column :reviews, :receiving_user_id, :integer, null: true
  end
end
