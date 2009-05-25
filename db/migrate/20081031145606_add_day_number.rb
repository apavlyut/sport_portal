class AddDayNumber < ActiveRecord::Migration
  def self.up
    add_column :days, :day_number, :integer
  end

  def self.down
    remove_column :days, :day_number
  end
end
