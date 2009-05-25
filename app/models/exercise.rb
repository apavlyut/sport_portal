class Exercise < ActiveRecord::Base
  has_many :day_lines
  belongs_to :strength_type
  has_and_belongs_to_many :muscular_groups
  
  belongs_to :first_image, :class_name => "Image", :foreign_key => "first_image_id"
  belongs_to :middle_image, :class_name => "Image", :foreign_key => "middle_image_id"
  belongs_to :last_image, :class_name => "Image", :foreign_key => "last_image_id"
  
  #validates_presence_of :title
  
end
