class CreateTrainingModes < ActiveRecord::Migration
  def self.up
    create_table :training_modes do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :training_modes
  end
end
