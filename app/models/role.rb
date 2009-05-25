class Role < ActiveRecord::Base
  attr_accessor :controllers_titles, :actions_titles
  validates_presence_of :rolename
  validates_uniqueness_of :rolename
  
  def self.public_roles
    exceptions = ['Admin only', 'Anonymouse']
    roles = Role.find(:all, :conditions => ['rolename NOT IN (?)', exceptions])
  end
end
