class AddGeneratingUserNameToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :generating_user_name, :string, null: false
    add_column :notifications, :generating_user_picture, :string
  end
end
