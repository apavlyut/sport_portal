class CreateGymAppartus < ActiveRecord::Migration
  def self.up
    create_table :gym_appartus do |t|
      t.integer :occupacy_id
      t.string :title
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :gym_appartus
  end
end
