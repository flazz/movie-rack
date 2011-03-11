require 'spec_helper'

describe Showtime do

  let :showtime do
    theater = Theater.create :name => 'Super Cinema 6'
    movie = Movie.create :title => 'Bambi'
    Showtime.new(:playing_at => Time.now,
                 :movie => movie,
                 :theater => theater)
  end

  it 'should be valid' do
    showtime.should be_valid
    showtime.errors.should be_empty
  end

  it 'should be invalid without a playing_at' do
    showtime.playing_at = nil
    showtime.should_not be_valid
    showtime.errors[:playing_at].should include("can't be blank")
  end

  it 'should be invalid without a movie' do
    showtime.movie = nil
    showtime.should_not be_valid
    showtime.errors[:movie_id].should include("can't be blank")
  end

  it 'should be invalid without a theater' do
    showtime.theater = nil
    showtime.should_not be_valid
    showtime.errors[:theater_id].should include("can't be blank")
  end

end

describe Showtime, '#listings' do

  let :movie do
    Movie.create :title => "Big Explosion II", :tagline => 'see the name, twice'
  end

  let :theater do
    Theater.create :name => "Super Cinema"
  end

  let :desired_time do
    Time.parse '12:10 pm'
  end

  let :showtimes do

    Showtime.create([
      { :playing_at => (desired_time - 1.hour), :movie => movie, :theater => theater},
      { :playing_at => (desired_time - 10.minutes), :movie => movie, :theater => theater},
      { :playing_at => (desired_time + 1.minute), :movie => movie, :theater => theater},
      { :playing_at => (desired_time + 14.minutes), :movie => movie, :theater => theater},
      { :playing_at => (desired_time + 40.minutes), :movie => movie, :theater => theater}
    ])

  end

  it 'should return times for the theater' do
    times = Showtime.listings(:for_movie => movie, :at_theater => theater).map &:playing_at
    times.each { |t| t.theater.should == movie }
  end

  it 'should return times for the movie' do
    times = Showtime.listings(:for_movie => movie, :at_theater => theater).map &:playing_at
    times.each { |t| t.movie.should == movie }
  end

  it 'should return times in ascending order' do
    times = Showtime.listings(:for_movie => movie, :at_theater => theater).map &:playing_at
    times.should == times.sort
  end

  it 'should require a movie option' do
    lambda {
      Showtime.listings(:at_theater => theater)
    }.should raise_error(ArgumentError, 'option :for_movie is required')
  end

  it 'should require a theater option' do
    lambda {
      Showtime.listings(:for_movie => movie)
    }.should raise_error(ArgumentError, 'option :at_theater is required')
  end

  it 'should not require a time option' do
    lambda {
      Showtime.listings(:for_movie => movie, :at_theater => theater)
    }.should_not raise_error(ArgumentError)
  end

  it 'should return only showtimes within a 20 minute window of the given time' do
    total_showings =  showtimes.size
    times = Showtime.listings(:for_movie => movie,
                              :at_theater => theater,
                              :around_time => desired_time)

    times.size.should == total_showings - 2

    times.each do |s|
      s.playing_at.should be_within(20.minutes).of(desired_time)
    end

  end

end
