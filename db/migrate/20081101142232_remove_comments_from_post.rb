class RemoveCommentsFromPost < ActiveRecord::Migration
  def self.up
    remove_column :posts, :comments
  end

  def self.down
    add_column :posts, :comments, :integer
  end
end
