class AddReportedToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :responses, :reported, :boolean
  end
end
