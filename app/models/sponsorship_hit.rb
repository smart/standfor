class SponsorshipHit < ActiveRecord::Base
  belongs_to :sponsorship
  belongs_to :my_badge

  def after_create

    self.my_badge.badge.hits += 1  
    self.my_badge.badge.save 

    self.my_badge.account.hits += 1  
    self.my_badge.account.save

  end

end
