class CreateExerciseSets < ActiveRecord::Migration
  def self.up
    create_table :exercise_sets do |t|
      t.integer :day_line_id, :weight, :repetitions, :time_rest
      t.timestamps
    end
  end

  def self.down
    drop_table :exercise_sets
  end
end
