class WorkoutItem < ActiveRecord::Base
  belongs_to :workout
  belongs_to :exercise
  has_many :exercise_sets
end
