class AddNotNullConstraingToReceivinguseridColumnNotifications < ActiveRecord::Migration[5.0]
  def self.up
    change_column :notifications, :receiving_user_id, :integer, null: false
  end

  def self.down
    change_column :notifications, :receiving_user_id, :integer, null: true
  end
end
