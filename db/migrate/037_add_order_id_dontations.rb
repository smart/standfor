class AddOrderIdDontations < ActiveRecord::Migration
  def self.up
    add_column :donations, :order_id, :integer
  end

  def self.down
    remove_column :donations, :order_id
  end
end
