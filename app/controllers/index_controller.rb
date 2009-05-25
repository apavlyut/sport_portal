class IndexController < ApplicationController
  layout 'start'
  def index
    # Nothing to do
    if logged_in?
      redirect_to pages_path
    end
  end
  
end
