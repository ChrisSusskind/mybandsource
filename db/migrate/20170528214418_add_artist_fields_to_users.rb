class AddArtistFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :artist?, :boolean
    add_column :users, :real_name, :string
    add_column :users, :data_quality, :string
    add_column :users, :facebook_url, :string
    add_column :users, :soundcloud_url, :string
    add_column :users, :spotify_url, :string
    add_column :users, :itunes_url, :string
    add_column :users, :twitter_url, :string
    add_reference :users, :genre, index: true
    add_foreign_key :users, :genres
  end
end