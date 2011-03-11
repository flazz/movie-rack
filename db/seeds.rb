# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Theater.create(
  [
    {:name => 'Gator Cinemas'},
    {:name => 'Royal Park Regal'},
    {:name => 'Regal Cinemas'}
])

Movie.create(
  [
    {:title => 'Napoleon Dynamite', :tagline => "A listless and alienated teenager decides to help his new friend win the class presidency in their small western high school, while he must deal with his bizarre family life back home."},
    {:title => 'The Longest Yard', :tagline => "A sadistic warden asks a former pro quarterback, now serving time in his prison, to put together a team of inmates to take on (and get pummeled by) the guards."},
    {:title => 'Smokey and the Bandit', :tagline => "The Bandit is hired on to run a tractor trailer full of beer over county lines in hot pursuit by a pesky sheriff."},
    {:title => 'The Cannonball Run', :tagline => "A wide variety of eccentric competitors participate in a wild and illegal cross-country car race"}
])



Theater.all.each do |t|

  Movie.all.each do |m|
    time = Time.now - 1.hours + rand(20).minutes

    14.times do
      time += rand(15).minutes
      s = Showtime.create :playing_at => time, :movie => m, :theater => t
      s.save
      time += 30.minutes
    end

  end

end
