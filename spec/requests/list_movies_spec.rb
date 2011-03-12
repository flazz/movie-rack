require 'spec_helper'

describe 'List Movies' do

  before :all do

    # make 3 theaters
    3.times do |n|
      Theater.create :name => "Super Cinema #{n}"
    end

    # two movies
    Movie.create :title => "Big Explosion II", :tagline => 'see the name, twice'
    Movie.create :title => "Wrong Side Up", :tagline => 'crazy romantic comedy'

    # and a few showtimes
    Theater.all.each do |t|
      Movie.all.each do |m|
        time = Time.parse('2:30 PM') + rand(70).minutes
        Showtime.create :playing_at => time, :movie => m, :theater => t, :available_tickets => 30
      end
    end

  end

  # this goes a bit deep, not as readable as i'd like
  it 'should list all movies with showtimes for theaters' do
    visit '/'

    all('.theater').size.should == 3
    all('.movie').size.should == 3 * 2

    Theater.all.each do |theater|

      within '.theater' do
        page.should have_selector('.name', :content => theater.name)

        theater.movies.all.each do |movie|

          within '.movie' do
            page.should have_selector('.title', :content => movie.title)

            movie.showtimes.where(:theater => theater) do |showtime|

              within '.showtime' do
                page.should have_link(showtime.time, :href => showtime_path(showtime))
              end

            end

          end

        end

      end

    end

  end

end

describe 'filtering showtimes' do

  it 'should be filterable by a given time of day' do
    movie = Movie.create :title => 'Napoleon Dynamite'
    movie.should be_persisted

    theater = Theater.create :name => 'Gator Cinemas'
    theater.should be_persisted

    desired_time_str = '2:30 PM'
    desired_time = Time.parse(desired_time_str)

    [-90, -21, -10, 1, 14, 21, 45].each do |n|
      time = desired_time + n.minutes
      st = Showtime.create :playing_at => time, :movie => movie, :theater => theater, :available_tickets => 30
      pp st.playing_at
      st.should be_persisted
    end

    visit '/'
    select desired_time_str
    click_button 'filter'
    all('.showtime a').should_not be_empty

    all('.showtime a').each do |a|
      show_time = Time.parse a.text
      show_time.should be_within(20.minutes).of(desired_time)
    end

  end

end
