class AddControllerToUserAccessAction < ActiveRecord::Migration
  def self.up
    add_column :user_access_actions, :cpntroller, :string
  end

  def self.down
    remove_column :user_access_actions, :cpntroller
  end
end
