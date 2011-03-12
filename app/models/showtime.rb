class Showtime < ActiveRecord::Base
  validates_presence_of :playing_at
  validates_presence_of :available_tickets

  validates_presence_of :movie_id
  validates_presence_of :theater_id

  belongs_to :movie
  belongs_to :theater

  has_many :receipts

  def self.listings options={}
    t = options[:at_theater] or raise ArgumentError, 'option :at_theater is required'
    m = options[:for_movie] or raise ArgumentError, 'option :for_movie is required'

    if options[:around_time]
      around_time = options[:around_time].utc
      start_time = (around_time - 20.minutes)
      end_time = (around_time + 20.minutes)
      Showtime.where(:movie_id => m, :theater_id => t, :playing_at => (start_time..end_time)).order('playing_at ASC')
    else
      Showtime.where(:movie_id => m, :theater_id => t).order('playing_at ASC')
    end

  end

end
