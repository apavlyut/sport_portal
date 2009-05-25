class RemoveControllerFromUserAccessAction < ActiveRecord::Migration
  def self.up
    remove_column :user_access_actions, :cpntroller
  end

  def self.down
    add_column :user_access_actions, :cpntroller, :string
  end
end
