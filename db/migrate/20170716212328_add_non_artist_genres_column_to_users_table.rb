class AddNonArtistGenresColumnToUsersTable < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :genres_list, :text, array:true, default: []
  end
end
