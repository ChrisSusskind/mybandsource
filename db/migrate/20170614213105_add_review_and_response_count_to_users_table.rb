class AddReviewAndResponseCountToUsersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :review_count, :integer, default: 0
    add_column :users, :response_count, :integer, default: 0
  end
end
