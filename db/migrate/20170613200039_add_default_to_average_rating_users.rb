class AddDefaultToAverageRatingUsers < ActiveRecord::Migration[5.0]
  def self.up
    change_column :users, :average_rating, :float, default: 0.0
  end

  def self.down
    change_column :users, :average_rating, :float
  end
end
