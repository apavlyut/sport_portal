class Muscle < ActiveRecord::Base
  belongs_to :muscular_group
  has_and_belongs_to_many :exercises
end
