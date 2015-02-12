class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.references :activity, index: true
      t.references :unit, index: true
      t.references :timeframe, index: true
      t.integer :measurement

      t.timestamps
    end
  end
end
