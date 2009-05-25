class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.integer :status
      t.string :login
      t.string :name
      t.string :phone
      t.string :email
      t.text :address
      t.text :extra

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
