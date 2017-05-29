class AddForeignKeyConstraintsToReviews < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :reviews, :users, column: :receiving_user_id
    add_foreign_key :reviews, :users, column: :leaving_user_id
  end
end
