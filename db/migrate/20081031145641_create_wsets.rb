class CreateWsets < ActiveRecord::Migration
  def self.up
    create_table :wsets do |t|
      t.integer :weight, :repetitions, :day_line_id
      t.timestamps
    end
  end

  def self.down
    drop_table :wsets
  end
end
