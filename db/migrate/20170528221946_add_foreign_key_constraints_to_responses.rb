class AddForeignKeyConstraintsToResponses < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :responses, :users
    add_foreign_key :responses, :reviews
  end
end
