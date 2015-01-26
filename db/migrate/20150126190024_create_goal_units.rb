class CreateGoalUnits < ActiveRecord::Migration
  def change
    create_table :goal_units do |t|
      t.string :description
      t.integer :value

      t.timestamps
    end
  end
end
