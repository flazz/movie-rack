class Receipt < ActiveRecord::Base
  validates_presence_of :tickets
  validates_presence_of :total

  belongs_to :showtime
  validates_presence_of :showtime_id
end
