class CreateJoinTableSubscriptions < ActiveRecord::Migration[5.0]
  def change
  	create_table :subscriptions do |t|
  		t.integer :user_id, null: false
			t.integer :artist_id, null: false

			t.index :user_id
  		t.index :artist_id
  	end
  end
end
