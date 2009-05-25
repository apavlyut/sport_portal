class CreateSystems < ActiveRecord::Migration
  def self.up
    create_table :systems do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
    
    System.create(:key => 'roles_active', :value => 'false')
  end

  def self.down
    drop_table :systems
  end
end
