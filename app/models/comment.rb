class Comment < ActiveRecord::Base 
  validates_presence_of :body, :on => :create, :message => "can't be blank"
  validates_presence_of :author, :on => :create, :message => "What is your name bloddy cheater!?"
end
