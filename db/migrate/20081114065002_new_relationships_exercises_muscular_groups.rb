class NewRelationshipsExercisesMuscularGroups < ActiveRecord::Migration
  def self.up
    rename_table :exercises_muscles, :exercises_muscular_groups
    rename_column :exercises_muscular_groups, :muscle_id, :muscular_group_id
  end

  def self.down
    rename_column :exercises_muscular_groups, :muscular_group_id, :muscle_id
    rename_table :exercises_muscular_groups, :exercises_muscles
  end
end
