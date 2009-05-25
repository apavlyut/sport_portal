class CreateWorkoutItems < ActiveRecord::Migration
  def self.up
    create_table :workout_items do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :workout_items
  end
end
