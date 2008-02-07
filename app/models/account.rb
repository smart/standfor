class Account< ActiveRecord::Base
  acts_as_youser
  has_many :my_badges
  has_many :donations
  has_many :orders
  has_and_belongs_to_many :access_codes
  has_and_belongs_to_many :roles
  has_one :sponsor
  has_one :avatar

   # you can extend this
  #REQUIRED_FIELDS = ['nickname', 'fullname', 'primary_email']
  REQUIRED_FIELDS = ['nickname' , 'primary_email']

  def total_donations(organization = nil)
     if organization.nil?
      0 + Donation.sum(:amount, :conditions =>{ :account_id => self.id } ).to_i
     else
      0 + Donation.sum(:amount, :conditions =>{ :account_id => self.id, 
						:organization_id => organization.id  } ).to_i
     end
  end

  def awareness_points
    100
  end

  def is_sponsor?
    return Sponsor.exists?(:account_id => self.id )
  end

  def organizations
    seen = []
    self.my_badges.each do |mb|
       seen << mb.badge.organization.id unless seen.include?(mb.badge.organization.id)
    end
    self.donations.each do |donation|
       seen << donation.organization.id unless seen.include?(donation.organization.id)
    end
    organizations = Organization.find(:all, :conditions => "id IN (#{seen.join(',')} )" ) 
  end

  def segments
    seen = []
    self.my_badges.each do |mb|
       seen << mb.badge.segment.id unless seen.include?(mb.badge.segment.id)
    end
    segments  = Segment.find(:all, :conditions => "id IN (#{seen.join(',')} )" ) 
  end
   
  def get_avatar(size)
   	!self.avatar.nil? ? self.avatar.public_filename(size) : "missing_avatar_#{size}.png"
  end

  def referred_money_raised
     total = 0
     self.my_badges.each do |mb|
       total += mb.referred_money_raised
     end
    total
  end
  
end
