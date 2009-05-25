class AddIsCompleteWorkoutColumn < ActiveRecord::Migration
  def self.up
    add_column :workouts, :is_complete, :boolean
  end

  def self.down
    remove_column :workouts, :is_complete
  end
  
end
