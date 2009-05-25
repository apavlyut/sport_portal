class CreateMuscles < ActiveRecord::Migration
  def self.up
    create_table :muscles do |t|
      t.string :title
      t.text :description
      t.integer :muscular_group_id
      t.timestamps
    end
  end

  def self.down
    drop_table :muscles
  end
end
