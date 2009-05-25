class CreateWorkouts < ActiveRecord::Migration
  def self.up
    create_table :workouts do |t|
      t.string :title
      t.text :description
      t.integer :workout_program_id
      t.timestamps
    end
  end

  def self.down
    drop_table :workouts
  end
end
