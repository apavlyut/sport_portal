class CreateTopMenus < ActiveRecord::Migration
  def self.up
    create_table :top_menus do |t|
      t.string :title
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :top_menus
  end
end
