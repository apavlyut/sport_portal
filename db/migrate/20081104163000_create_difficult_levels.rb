class CreateDifficultLevels < ActiveRecord::Migration
  def self.up
    create_table :difficult_levels do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :difficult_levels
  end
end
