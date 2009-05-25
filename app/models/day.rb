class Day < ActiveRecord::Base
  belongs_to :workout
  belongs_to :week_day, :foreign_key => "day_number"
  has_many :day_lines, :dependent => :destroy, :order => :position
  has_many :exercises, :through => :day_lines
  has_and_belongs_to_many :muscular_groups
  # validates_presence_of :title
end
