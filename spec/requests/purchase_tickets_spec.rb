describe 'Purchasing Tickets' do

  it 'should allow a customer to purchase a ticket for a chosen movie and showtime' do
    some_showtime = Showtime.make

    visit '/'
    find("a[href='#{showtime_link(some_showtime)}']").click_link

    page.should have_content(some_showtime.theater.name)
    page.should have_content(some_showtime.movie.title)
    page.should have_content(some_showtime.to_s)

    click_button 'Purchase Tickets'

    page.should have_content(some_showtime.theater.name)
    page.should have_content(some_showtime.movie.title)
    page.should have_content("regular tickets: 1")
    page.should have_content("$10.00")
    page.should have_content("This is your proof, please print")
  end

  it 'should allow the number of tickets to be chosen' do
    some_showtime = Showtime.make

    visit '/'
    find("a[href='#{showtime_link(some_showtime)}']").click_link

    page.should have_content(some_showtime.theater.name)
    page.should have_content(some_showtime.movie.title)
    page.should have_content(some_showtime.to_s)
    select '3', :from => 'Tickets'

    click_button 'Purchase Tickets'

    page.should have_content(some_showtime.theater.name)
    page.should have_content(some_showtime.movie.title)
    page.should have_content("regular tickets: 2")
    page.should have_content("$20.00")
    page.should have_content("This is your proof, please print")
  end

  it 'should inform the user when the number of tickets exceeds the number of avaiable seats' do
    left_over = 5
    want_to_by = left_over + 1
    some_showtime = Showtime.make :available_tickets => left_over

    visit '/'
    find("a[href='#{showtime_link(some_showtime)}']").click_link

    page.should have_content(some_showtime.theater.name)
    page.should have_content(some_showtime.movie.title)
    page.should have_content(some_showtime.to_s)
    select want_to_by.to_s, :from => 'Tickets'

    click_button 'Purchase Tickets'

    within '.alert' do
      page.should have_content("#{want_to_by} tickets are not avaiable, only #{left_over}")
    end

    select left_over.to_s, :from => 'Tickets'
    click_button 'Purchase Tickets'
    page.should have_content(some_showtime.theater.name)
    page.should have_content(some_showtime.movie.title)
    page.should have_content("regular tickets: #{left_over}")
    page.should have_content("$25.00")
    page.should have_content("This is your proof, please print")
  end

  it 'should sell cheap seats at a 50% discount after all regular seats are sold' do
    some_showtime = Showtime.make :available_tickets => CHEAP_TIX_AVAILABLE

    visit '/'
    find("a[href='#{showtime_link(some_showtime)}']").click_link

    page.should have_content("Cheap seats are available, 50% off regular price!")
    page.should have_content(some_showtime.theater.name)
    page.should have_content(some_showtime.movie.title)
    page.should have_content(some_showtime.to_s)

    click_button 'Purchase Tickets'

    page.should have_content(some_showtime.theater.name)
    page.should have_content(some_showtime.movie.title)
    page.should have_content("cheap tickets: 1")
    page.should have_content("$5.00")
    page.should have_content("This is your proof, please print")
  end

end
