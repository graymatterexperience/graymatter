class ModifyUsersTable < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cohort_id, :integer
    add_column :users, :user_information, :jsonb, null: false, default: '{}'
    add_index  :users, :user_information, using: :gin
  end
end
