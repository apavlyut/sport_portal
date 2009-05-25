class Category < ActiveRecord::Base
  acts_as_nested_set
  has_many :categorizations
  has_many :products, :through => :categorizations
  
  validates_presence_of :title
	validates_uniqueness_of :title
	validates_presence_of :transcrib
	validates_uniqueness_of :transcrib
	
end
