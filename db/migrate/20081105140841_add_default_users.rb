class AddDefaultUsers < ActiveRecord::Migration
  def self.up
    User.create(
      :login => "admin",
      :email => "admin@fitset.ru",
      :password => "admin",
      :password_confirmation => "admin",
      :activated_at => Time.now.utc
    )
    
    User.create(
      :login => "deppkind",
      :email => "deppkind@gmail.com",
      :password => "qwer",
      :password_confirmation => "qwer",
      :activated_at => Time.now.utc
    )
    
    User.create(
      :login => "godspirit",
      :email => "ab@fitset.ru",
      :password => "2222",
      :password_confirmation => "2222",
      :activated_at => Time.now.utc
    )
    
    User.create(
      :login => "tsambika",
      :email => "tsambika@mail.ru",
      :password => "3333",
      :password_confirmation => "3333",
      :activated_at => Time.now.utc
    )
    
  end

  def self.down
  end
end
