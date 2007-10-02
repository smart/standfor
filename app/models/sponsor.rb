class Sponsor < ActiveRecord::Base
  has_many :sponsorships
  has_one :sponsorslogo
  belongs_to :account
  validates_presence_of :name, :site_name

  def sponsored 
     sponsorships.collect {|sponsorship| sponsorship.sponsorable }
  end

  def sponsor(sponsorable)
    return false if !sponsorable.new_record? && sponsored.include?(sponsorable)
    sponsorships.create :sponsorable => sponsorable 
    return true 
  end
  
  def total_spent
    total = 0
    sponsorships.each do |sponsorship|
      total += sponsorship.total_spent 
    end
    return total
  end

  def to_param
    "#{id}"
  end
     

end
