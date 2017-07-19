class AddFeaturedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :featured, :boolean
    add_index :users, :featured
  end
end
