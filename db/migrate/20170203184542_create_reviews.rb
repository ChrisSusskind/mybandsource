class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :comment
      t.integer :rating_1
      t.integer :rating_2
      t.integer :rating_3
      t.timestamps
    end
  end
end
