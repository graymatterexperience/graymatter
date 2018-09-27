class AddSettingsToCohort < ActiveRecord::Migration[5.1]
  def change
    add_column :cohorts, :settings, :jsonb
  end
end
