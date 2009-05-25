class AddNewFieldsToWorkout < ActiveRecord::Migration
  def self.up
    create_table :users_workouts, :id => false do |t| 
      t.column :user_id, :integer 
      t.column :workout_id, :integer 
    end
    
    add_column :workouts, :difficult_level_id, :integer
    add_column :workouts, :gender, :string, :limit => 1
    add_column :workouts, :age_level_id, :integer
    add_column :workouts, :goal_id, :integer
    add_column :workouts, :occupacy_id, :integer
    add_column :workouts, :training_mode_id, :integer
    remove_column :workouts, :workout_program_id
    
    add_column :days, :cycle_id, :integer
    add_column :days, :muscular_group_id, :integer
    
    add_column :exercises, :strength_type_id, :integer
    
    create_table :exercises_gym_appartus, :id => false do |t| 
      t.column :exercise_id, :integer 
      t.column :gym_appartus_id, :integer 
    end
    
    
    create_table :images_gym_appartus, :id => false do |t| 
      t.column :image_id, :integer 
      t.column :gym_appartus_id, :integer 
    end
  end

  def self.down
    drop_table :images_gym_appartus
    
    drop_table :exercises_gym_appartus
    
    remove_column :exercises, :strength_type_id
    
    remove_column :days, :muscular_group_id
    remove_column :days, :cycle_id
    
    add_column :workouts, :workout_program_id, :integer
    remove_column :workouts, :training_mode_id
    remove_column :workouts, :occupacy_id
    remove_column :workouts, :goal_id
    remove_column :workouts, :age_level_id
    remove_column :workouts, :gender
    remove_column :workouts, :difficult_level_id
    drop_table :users_workouts
  end
end
