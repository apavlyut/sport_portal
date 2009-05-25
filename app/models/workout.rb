class Workout < ActiveRecord::Base
  #belongs_to :workout_program
  #has_many :workout_items
  #
  #validates_presence_of :title
  belongs_to :user
  has_many :days, :dependent => :destroy
  belongs_to :difficult_level
  belongs_to :goal
    
  #has_and_belongs_to_many :clients, :join_table => "users_workouts", :foreign_key => "user_id"
  
  #validates_presence_of :title, :message => "&mdash Название надо ввести"

end