class CreateUserAccessActions < ActiveRecord::Migration
  def self.up
    create_table :user_access_actions do |t|
      t.integer :user_role
      t.string :action

      t.timestamps
    end
  end

  def self.down
    drop_table :user_access_actions
  end
end
