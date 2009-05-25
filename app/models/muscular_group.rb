class MuscularGroup < ActiveRecord::Base
  has_many :muscles, :dependent => :destroy
  has_and_belongs_to_many :exercises
end
