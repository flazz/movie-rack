class Movie < ActiveRecord::Base
  validates_presence_of :title

  has_many :showtimes
  has_many :theaters, :through => :showtimes, :uniq => true
end
