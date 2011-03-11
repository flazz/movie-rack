module ListingsHelper

  def select_half_hours name

    half_hours = (0..23).inject([]) do |acc, n|

      if n == 0
        acc << "12:00 am"
        acc << "12:30 am"
      elsif n < 12
        acc << "#{n}:00 am"
        acc << "#{n}:30 am"
      elsif n == 12
        acc << "12:00 pm"
        acc << "12:30 pm"
      else
        acc << "#{n - 12}:00 pm"
        acc << "#{n - 12}:30 pm"
      end

      acc
    end

    select_tag name, options_for_select(half_hours)
  end

end
