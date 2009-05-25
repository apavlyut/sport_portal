class Product < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, :through => :categorizations
  has_many :orderings
  has_many :orders, :through => :orderings
  
  validates_presence_of :title, :image_id, :price, :description
	validates_uniqueness_of :title
	validates_numericality_of :price
	                    
	protected
	
	def validate
	  errors.add(:price, "should be positive, man") if price.nil? || price <= 0	 
	end
	
end
