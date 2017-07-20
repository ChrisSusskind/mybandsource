class AddDefaultReportedFalseToReviewsAndResponses < ActiveRecord::Migration[5.0]
  def change
    change_column :responses, :reported, :boolean, default: false
    change_column :reviews, :reported, :boolean, default: false
  end
end
