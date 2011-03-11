describe 'List Movies' do

  # this goes a bit deep, not as readable as i like
  it 'should list all movies with showtimes for theaters' do
    visit '/'

    Theater.all.each do |theater|

      within '.theater' do
        page.should have_selector('.name', :content => theater.name)

        theater.movies.all.each do |movie|

          within '.movie' do
            page.should have_selector('.title', :content => movie.title)

            movie.showtimes.where(:theater => t) do |showtime|

              within '.showtime' do
                page.should have_link(showtime.time, :href => showtime_path(showtime))
              end

            end

          end

        end

      end

    end

  end

  it 'should be filterable by a given time of day' do
    desired_time_str = '2:30 pm'
    desired_time = Time.parse desired_time_str

    visit '/'
    select desired_time_str
    click_button 'filter'

    all('.showtime a').each do |a|
      show_time = Time.parse a.content
      show_time.should be_within(20.minutes).of(desired_time)
    end

  end

end
