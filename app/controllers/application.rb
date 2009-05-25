# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include AuthenticatedSystem
  include UserAccess
  
  # Проверка уровня доступа пользователя
  before_filter :check_acess
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '761963a9bd73ad16eeac72ca6263b83c'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  protected
  
  def check_acess
    # Http доступ
    # authenticate unless ENV["RAILS_ENV"] == "development"
    
    # Права доступа к страницам/разделам - Педро знает =)
    #hello!
  end
  
  # В продакшене на сайте доступ надо закрыть для посторонних
  # поэтому используем Basic HTTP Authorization в Rails
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "visitor" && password == "new_password_23"
    end
  end
  
  
end
