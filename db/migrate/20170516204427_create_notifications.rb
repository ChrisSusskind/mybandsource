class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :generating_user, null: false
      t.references :receiving_user
      t.references :receiving_artist
      t.references :review
      t.references :response
      t.string :notification_type
      t.boolean :viewed, default: false

      t.timestamps
    end
    add_foreign_key :notifications, :users, column: :generating_user_id
    add_foreign_key :notifications, :users, column: :receiving_user_id
    add_foreign_key :notifications, :artists, column: :receiving_artist_id
    add_foreign_key :notifications, :reviews
    add_foreign_key :notifications, :responses
  end
end
