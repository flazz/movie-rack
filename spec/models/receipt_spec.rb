require 'spec_helper'

describe Receipt do

  let :receipt do
    theater = Theater.create :name => 'Super Cinema 6'
    movie = Movie.create :title => 'Bambi'
    showtime = Showtime.create(:playing_at => Time.now,
                               :movie => movie,
                               :available_tickets => 30,
                               :theater => theater)

    Receipt.new :total => 10.00, :tickets => 1, :showtime => showtime
  end

  it 'should be valid' do
    receipt.should be_valid
    receipt.errors.should be_empty
    receipt.save.should be_true
  end

  it 'should be invalid without tickets' do
    receipt.total = nil
    receipt.should_not be_valid
    receipt.errors[:total].should include("can't be blank")
  end

  it 'should be invalid without total' do
    receipt.tickets = nil
    receipt.should_not be_valid
    receipt.errors[:tickets].should include("can't be blank")
  end

  it 'should be invalid without showtime' do
    receipt.showtime = nil
    receipt.should_not be_valid
    receipt.errors[:showtime_id].should include("can't be blank")
  end

end
