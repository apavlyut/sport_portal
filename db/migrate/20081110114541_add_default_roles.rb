class AddDefaultRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :comment, :text
    add_column :roles, :parent_id, :integer

    Role.create(:rolename => 'Administrator', :comment => 'Чувак с рутовыми правами')
    Role.create(:rolename => 'Admin only', :comment => 'Методы, разрешенные только администратору. Будут скрыты для прочих')
    Role.create(:rolename => 'Anonymouse', :comment => 'Права для незалогиненного пользователя')
    Role.create(:rolename => 'User', :comment => 'Базовые права для залогиненного пользователя')
  end

  def self.down
    remove_column :roles, :comment
    remove_column :roles, :integer
  end
end
