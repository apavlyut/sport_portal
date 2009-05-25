class AddMuscularGroupsAndDaysJoinTable < ActiveRecord::Migration
  def self.up
    create_table :days_muscular_groups, :id => false do |t| 
      t.column :day_id, :integer 
      t.column :muscular_group_id, :integer 
    end
  end

  def self.down
    drop_table :days_muscular_groups
  end
end
