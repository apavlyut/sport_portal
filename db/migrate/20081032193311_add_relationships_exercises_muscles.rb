class AddRelationshipsExercisesMuscles < ActiveRecord::Migration
  def self.up
    create_table :exercises_muscles, :id => false do |t| 
      t.column :exercise_id, :integer 
      t.column :muscle_id, :integer 
    end
  end

  def self.down
    drop_table :exercises_muscles
  end
end
