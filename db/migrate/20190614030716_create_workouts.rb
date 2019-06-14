class CreateWorkouts < ActiveRecord::Migration[5.2]
  def change
    create_table :workouts do |t|
      t.string :name
      t.string :description
      t.string :instructions
      t.integer :user_id
      t.timestamps
    end
  end
end
