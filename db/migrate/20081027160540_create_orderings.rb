class CreateOrderings < ActiveRecord::Migration
  def self.up
    create_table :orderings do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :orderings
  end
end
