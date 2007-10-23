class Order < ActiveRecord::Base
  belongs_to :account
  has_many :donations

  def total
    total = 0
    self.donations.each do |donation| 
       total += donation.amount
    end
    total
  end

end
