module ShowtimesHelper

  def simple_time_format t
    t.strftime("%I:%M %p")
  end

  def showtime_link s
    link_to simple_time_format(s.playing_at.in_time_zone), showtime_path(s)
  end

  def select_half_hours name

    half_hours = (0..23).inject(ActiveSupport::OrderedHash.new) do |acc, n|
      on_the_hour = Time.now.midnight + n.hours
      on_the_half_hour = on_the_hour + 30.minutes

      [on_the_hour, on_the_half_hour].each do |t|
        key = t.strftime('%I:%M %p')
        acc[key] = t.xmlschema
      end

      acc
    end

    select_tag name, options_for_select(half_hours)
  end

end