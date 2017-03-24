class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.integer :upvotes, default: 0
      t.text :upvotes_userlist, array: true, default: []
      t.text :comment, null: false
      t.integer :user_id
      t.integer :review_id, index: true

      t.timestamps
    end
  end
end
