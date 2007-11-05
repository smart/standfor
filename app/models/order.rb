class Order < ActiveRecord::Base
  belongs_to :account
  has_many :donations

  attr_accessor :confirmed
  attr_accessor :creditcard

  def to_param 
    "#{id}"
  end

  def total
    total = 0
    self.donations.each do |donation| 
       total += donation.amount
    end
    total
  end

end
