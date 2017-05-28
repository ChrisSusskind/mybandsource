class RemoveNotNullConstraintsEmailPasswordUsers < ActiveRecord::Migration[5.0]
  def self.up
    change_column :users, :email, :string, null: true
    change_column :users, :encrypted_password, :string, null: true
  end

  def self.down
    change_column :users, :email, :string, null: false
    change_column :users, :encrypted_password, :string, null: false
  end
end
