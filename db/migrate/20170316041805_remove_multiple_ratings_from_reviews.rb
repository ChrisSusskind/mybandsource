class RemoveMultipleRatingsFromReviews < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :rating_1, :integer
    remove_column :reviews, :rating_2, :integer
    remove_column :reviews, :rating_3, :integer
    add_column :reviews, :rating, :integer
  end
end
