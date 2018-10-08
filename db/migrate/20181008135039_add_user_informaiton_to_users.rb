class AddUserInformaitonToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :user_information, :jsonb, null: false, default: {}
  end
end
