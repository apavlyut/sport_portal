class CreateStrengthTypes < ActiveRecord::Migration
  def self.up
    create_table :strength_types do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :strength_types
  end
end
