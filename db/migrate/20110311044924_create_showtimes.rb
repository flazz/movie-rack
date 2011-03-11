class CreateShowtimes < ActiveRecord::Migration
  def self.up
    create_table :showtimes do |t|
      t.integer :available_tickets
      t.time :playing_at

      t.timestamps
    end
  end

  def self.down
    drop_table :showtimes
  end
end
