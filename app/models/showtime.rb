class Showtime < ActiveRecord::Base
  validates_presence_of :playing_at
  validates_presence_of :movie_id
  validates_presence_of :theater_id

  belongs_to :movie
  belongs_to :theater
end
