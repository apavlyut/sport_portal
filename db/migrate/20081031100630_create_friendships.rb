class CreateFriendships < ActiveRecord::Migration
  def self.up
    create_table :friendships do |t|
      t.string :a
      t.string :b
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :friendships
  end
end
