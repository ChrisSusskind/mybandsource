class AddReportedToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :reported, :boolean
  end
end
