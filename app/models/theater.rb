class Theater < ActiveRecord::Base
  validates_presence_of :name

  has_many :showtimes
  has_many :movies, :through => :showtimes, :uniq => true
end
