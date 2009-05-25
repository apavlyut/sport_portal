class AddThreeImageIdToExercise < ActiveRecord::Migration
  def self.up
    add_column :exercises, :first_image_id, :integer
    add_column :exercises, :middle_image_id, :integer
    add_column :exercises, :last_image_id, :integer
  end

  def self.down
    remove_column :exercises, :first_image_id
    remove_column :exercises, :middle_image_id
    remove_column :exercises, :last_image_id
  end
end
