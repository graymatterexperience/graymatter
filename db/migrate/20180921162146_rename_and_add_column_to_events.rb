class RenameAndAddColumnToEvents < ActiveRecord::Migration[5.1]
  def change
    rename_column :events, :start_time, :start
    rename_column :events, :end_time, :end
    add_column :events, :color, :string
  end
end
