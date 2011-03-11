describe 'Purchasing Tickets' do

  let! :showtime do
    movie = Movie.create :title => 'Napoleon Dynamite'
    movie.save

    theater = Theater.create :name => 'Gator Cinemas'
    theater.save

    s = Showtime.create(:playing_at => Time.now, :movie => movie, :theater => theater, :available_tickets => 30)
    s.save or raise "can't save showtime"
    s
  end

  it 'should allow a customer to purchase a ticket for a chosen movie and showtime' do
    visit '/'
    find("a[href='#{showtime_path(showtime)}']").click

    page.should have_content(showtime.theater.name)
    page.should have_content(showtime.movie.title)
    page.should have_content(showtime.playing_at.strftime('%I:%M %p'))

    click_button 'Purchase Tickets'

    page.should have_content(showtime.theater.name)
    page.should have_content(showtime.movie.title)
    page.should have_content("regular tickets: 1")
    page.should have_content("$10.00")
    page.should have_content("This is your proof, please print")
  end

  it 'should allow the number of tickets to be chosen' do
    visit '/'
    find("a[href='#{showtime_path(showtime)}']").click

    page.should have_content(showtime.theater.name)
    page.should have_content(showtime.movie.title)
    page.should have_content(showtime.playing_at.strftime('%I:%M %p'))
    select '3', :from => 'Tickets'

    click_button 'Purchase Tickets'

    page.should have_content(showtime.theater.name)
    page.should have_content(showtime.movie.title)
    page.should have_content("regular tickets: 3")
    page.should have_content("$30.00")
    page.should have_content("This is your proof, please print")
  end

  it 'should inform the user when the number of tickets exceeds the number of avaiable seats' do
    left_over = 5
    want_to_by = left_over + 1
    showtime.available_tickets = left_over
    showtime.save

    visit '/'
    find("a[href='#{showtime_path(showtime)}']").click

    page.should have_content(showtime.theater.name)
    page.should have_content(showtime.movie.title)
    page.should have_content(showtime.playing_at.strftime('%I:%M %p'))
    select want_to_by.to_s, :from => 'Tickets'

    click_button 'Purchase Tickets'

    within '.alert' do
      page.should have_content("#{want_to_by} tickets are not avaiable, only #{left_over}")
    end

    select left_over.to_s, :from => 'Tickets'
    click_button 'Purchase Tickets'
    page.should have_content(showtime.theater.name)
    page.should have_content(showtime.movie.title)
    page.should have_content("regular tickets: #{left_over}")
    page.should have_content("$25.00")
    page.should have_content("This is your proof, please print")
  end

  it 'should sell cheap seats at a 50% discount after all regular seats are sold' do
    showtime.available_tickets = CHEAP_TIX_AVAILABLE
    showtime.save

    visit '/'
    find("a[href='#{showtime_path(showtime)}']").click

    page.should have_content("Cheap seats are available, 50% off regular price!")
    page.should have_content(showtime.theater.name)
    page.should have_content(showtime.movie.title)
    page.should have_content(showtime.to_s)

    click_button 'Purchase Tickets'

    page.should have_content(showtime.theater.name)
    page.should have_content(showtime.movie.title)
    page.should have_content("cheap tickets: 1")
    page.should have_content("$5.00")
    page.should have_content("This is your proof, please print")
  end

end
