class AddNotNullConstraintToReviewidResponses < ActiveRecord::Migration[5.0]
  def self.up
    change_column :responses, :review_id, :integer, null: false
    change_column :responses, :user_id, :integer, null: false
  end

  def self.down
    change_column :responses, :review_id, :integer, null: true
    change_column :responses, :user_id, :integer, null: true
  end
end
