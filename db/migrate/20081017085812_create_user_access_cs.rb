class CreateUserAccessCs < ActiveRecord::Migration
  def self.up
    create_table :user_access_cs do |t|
      t.integer :user_role
      t.string :controller

      t.timestamps
    end
  end

  def self.down
    drop_table :user_access_cs
  end
end
