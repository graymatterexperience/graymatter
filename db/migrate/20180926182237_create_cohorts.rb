class CreateCohorts < ActiveRecord::Migration[5.1]
  def change
    create_table :cohorts do |t|
      t.string :name
      t.jsonb :settings, null: false, default: '{}'

      t.timestamps
    end

    add_index :cohorts, :settings, using: :gin
  end
end