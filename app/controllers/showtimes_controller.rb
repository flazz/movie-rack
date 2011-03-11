class ShowtimesController < ApplicationController

  def index

    if params['specific_time']
      @specific_time = Time.parse params['specific_time']
    end

    @theaters = Theater.all
  end

  def show
    @showtime = Showtime.find params[:id]
  end

  def purchase
    @showtime = Showtime.find params[:id]

    # TODO make sure this is an integer between 1-10
    @tickets_purchased = params[:tickets_purchased].to_i

    @total = @tickets_purchased * REGULAR_TICKET_PRICE
  end

end
