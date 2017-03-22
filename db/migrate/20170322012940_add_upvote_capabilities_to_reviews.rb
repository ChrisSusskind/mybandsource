class AddUpvoteCapabilitiesToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :upvotes, :integer, default: 0
    add_column :reviews, :upvotes_userlist, :text, array: true, default: []
  end
end
