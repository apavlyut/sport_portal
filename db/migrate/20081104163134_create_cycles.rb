class CreateCycles < ActiveRecord::Migration
  def self.up
    create_table :cycles do |t|
      t.integer :workout_id
      t.timestamps
    end
  end

  def self.down
    drop_table :cycles
  end
end
