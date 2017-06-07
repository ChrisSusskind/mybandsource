class AddUserIdColumnToGenreTable < ActiveRecord::Migration[5.0]
  def change
    add_column :genres, :user_id, :integer
    add_foreign_key :genres, :users, column: :user_id
  end
end
