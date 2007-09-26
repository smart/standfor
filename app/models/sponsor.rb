class Sponsor < ActiveRecord::Base
  has_many :sponsorships

  def sponsored 
     sponsorships.collect {|sponsorship| sponsorship.sponsorable }
  end

  def sponsor(sponsorable)
    return false if !sponsorable.new_record? && sponsored.include?(sponsorable)
    sponsorships.create :sponsorable => sponsorable 
    return true 
  end

end
