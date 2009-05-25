class CreateAgeLevels < ActiveRecord::Migration
  def self.up
    create_table :age_levels do |t|
      t.string :title
      t.integer :from_age, :to_age
      t.timestamps
    end
  end

  def self.down
    drop_table :age_levels
  end
end
