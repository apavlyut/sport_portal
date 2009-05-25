class ManagementController < ApplicationController
  
  def exercises
    @exercies = Exercise.find(:all)
  end
  
  
  
end
