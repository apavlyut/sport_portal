class AddController2ToUserAccessAction < ActiveRecord::Migration
  def self.up
    add_column :user_access_actions, :controller, :string
  end

  def self.down
    remove_column :user_access_actions, :controller
  end
end
