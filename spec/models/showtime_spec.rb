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
