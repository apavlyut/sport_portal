class CreateMuscularGroups < ActiveRecord::Migration
  def self.up
    create_table :muscular_groups do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
  end
  
  def self.down
    drop_table :muscular_groups
  end
  
end