class CreateWeekDays < ActiveRecord::Migration
  def self.up
    create_table :week_days do |t|
      t.string :title, :short_name
      t.integer :number
      t.timestamps
    end
  end

  def self.down
    drop_table :week_days
  end
end
