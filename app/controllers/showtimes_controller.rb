class ShowtimesController < ApplicationController

  def index

    if params['specific_time']

      begin
        @specific_time = Time.parse params['specific_time']
      rescue
        render :nothing => true, :status => '400' and return
      end

    end

    @theaters = Theater.all
  end

  def show
    @showtime = Showtime.find params[:id]
  end

  def purchase
    @showtime = Showtime.find params[:id]

    unless params[:tickets_purchased] =~ /^\d+$/
      render :nothing => true, :status => '400' and return
    end

    @tickets_purchased = params[:tickets_purchased].to_i

    if @showtime.available_tickets < @tickets_purchased
      alert_msg = "#{@tickets_purchased} tickets are not available, only #{@showtime.available_tickets}"
      redirect_to :back, :alert => alert_msg and return
    end

    @total = @tickets_purchased * REGULAR_TICKET_PRICE
  end

end
