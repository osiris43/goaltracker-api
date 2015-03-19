class CreateProgressEvents < ActiveRecord::Migration
  def change
    create_table :progress_events do |t|
      t.integer :number
      t.references :goal, index: true

      t.timestamps null: false
    end
    add_foreign_key :progress_events, :goals
  end
end
