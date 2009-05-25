class CreateDayLines < ActiveRecord::Migration
  def self.up
    create_table :day_lines do |t|
      t.integer :day_id, :exercise_id, :position
      t.timestamps
    end
  end

  def self.down
    drop_table :day_lines
  end
  
end
