class ModifyOrdersAndDonations < ActiveRecord::Migration
  def self.up
     add_column :orders, :last_four_digits, :string
     add_column :orders, :payment_authorization, :string
     add_column :orders, :amount, :integer
     remove_column :donations, :last_four_digits
     remove_column :donations, :payment_authorization
  end

  def self.down
     remove_column :orders, :last_four_digits
     remove_column :orders, :payment_authorization
     remove_column :orders, :amount
     add_column :donations, :last_four_digits, :string
     add_column :donations, :payment_authorization, :string
  end
end
