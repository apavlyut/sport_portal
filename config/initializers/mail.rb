# Email settings
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "fl00r@yandex.ru",
  :port => 25,
  :domain => "fitset.ru",
  :authentication => :login,
  :user_name => "fl00r@yandex.ru",
  :password => "asd123"  
}