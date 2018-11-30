class ChangeCohortSettings < ActiveRecord::Migration[5.1]
  def change
    remove_column :cohorts, :settings, :jsonb
  end
end
