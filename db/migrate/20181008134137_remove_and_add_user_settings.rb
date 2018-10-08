class RemoveAndAddUserSettings < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :user_information, :jsonb
  end
end
