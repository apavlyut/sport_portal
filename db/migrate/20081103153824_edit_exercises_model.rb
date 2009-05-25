class EditExercisesModel < ActiveRecord::Migration
  def self.up
    create_table :exercises_images, :id => false do |t| 
      t.column :exercise_id, :integer 
      t.column :image_id, :integer 
    end
  end

  def self.down
    drop_table :exercises_images
  end
end
