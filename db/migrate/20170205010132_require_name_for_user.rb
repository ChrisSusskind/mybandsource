class RequireNameForUser < ActiveRecord::Migration[5.0]
  def self.up
    change_column :users, :name, :string, null: false, default: ''
  end

  def self.down
    change_column :users, :name, :string
  end
end
