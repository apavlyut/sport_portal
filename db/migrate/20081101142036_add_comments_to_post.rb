class AddCommentsToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :comments, :integer
  end

  def self.down
    remove_column :posts, :comments
  end
end
