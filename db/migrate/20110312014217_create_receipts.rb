class CreateReceipts < ActiveRecord::Migration
  def self.up
    create_table :receipts do |t|
      t.integer :tickets
      t.boolean :is_cheap
      t.float :total

      t.references :showtime

      t.timestamps
    end
  end

  def self.down
    drop_table :receipts
  end
end
