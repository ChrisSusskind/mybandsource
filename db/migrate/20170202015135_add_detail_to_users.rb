class AddDetailToUsers < ActiveRecord::Migration[5.0]
  def change
  	
	#Data type changes to be made upon switch to PostgreSQL: city: Point

  	add_column :users, :name, :string
  	add_column :users, :location, :string, null: true
  	add_index :users, :location
  	
  end
end
