class AddNotNullConstraingToIsartistColumnUsers < ActiveRecord::Migration[5.0]
  def self.up
    change_column :users, :is_artist, :boolean, null: false
  end

  def self.down
    change_column :users, :is_artist, :boolean, null: true
  end
end
