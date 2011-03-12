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

    if @showtime.available_tickets <= CHEAP_TIX_AVAILABLE
      flash[:notice] = 'Cheap seats are available, 50% off regular price!'
    end

  end

  verify :params => 'tickets_purchased', :only => :purchase

  def purchase
    showtime = Showtime.find params[:id]

    unless params[:tickets_purchased] =~ /^\d+$/
      render :nothing => true, :status => '400' and return
    end

    tickets_purchased = params[:tickets_purchased].to_i

    if showtime.available_tickets < tickets_purchased
      alert_msg = "#{tickets_purchased} tickets are not available, only #{showtime.available_tickets}"
      redirect_to :back, :alert => alert_msg and return
    end

    receipt = Receipt.new :showtime => showtime
    receipt.is_cheap = showtime.available_tickets <= CHEAP_TIX_AVAILABLE
    unit_price = if receipt.is_cheap
                   REGULAR_TICKET_PRICE / 2.0
                 else
                   REGULAR_TICKET_PRICE
                 end

    receipt.total = tickets_purchased * unit_price
    receipt.tickets = tickets_purchased
    receipt.save or raise "can't save receipt"

    showtime.available_tickets -= tickets_purchased
    showtime.save or raise "can't save showtime"

    redirect_to receipt_path(receipt), :notice => 'Thank you for your purchase, enjoy the show'
  end

end
