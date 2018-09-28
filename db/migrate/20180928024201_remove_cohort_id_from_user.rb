class RemoveCohortIdFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :cohort_id, :integer
  end
end
