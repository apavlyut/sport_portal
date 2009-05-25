class DayLine < ActiveRecord::Base
  belongs_to :day
  belongs_to :exercise
  has_many :exercise_sets, :dependent => :destroy
    
end
