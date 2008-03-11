class Account< ActiveRecord::Base
  STATS_CACHE = 900
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

  def self.verify_reset_code(code)  
    #Account.find(:first, :conditions => ["reset_password_code = ? and updated_at > ? ", code , Time.now - 1.hour ] )
    acct = Account.find(:first, :conditions => ["reset_password_code = ?  ", code  ] )
    acct
  end

  def expire_reset_code
    self.reset_password_code = ''
    self.save
  end

  def forgot_password
     @forgotten_password = true
     self.make_password_reset_code
  end

  def reset_password
   update_attributes(:reset_password_code => nil)
   @reset_password = true
  end

  def recently_forgot_password?
    @forgotten_password
  end

  def make_password_reset_code
      self.reset_password_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end

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
   	(self.avatar.nil?) ? "missing_avatar_#{size}.png" : self.avatar.public_filename(size) 
  end

  def referred_money_raised
     total = 0
     self.my_badges.each do |mb|
       total += mb.referred_money_raised
     end
    total
  end
  
  def update_stats
    total_hits = 0
    total_clicks = 0
    total_unique_hits = 0
    total_unique_clicks = 0
    self.my_badges.each do |badge|
      total_hits += badge.total_hits
      total_clicks += badge.total_clicks
      total_unique_hits += badge.total_unique_hits
      total_unique_clicks += badge.total_unique_clicks
    end
     self.update_attributes(:total_hits => total_hits, :total_clicks => total_clicks,
                             :total_unique_hits => total_unique_hits, :total_unique_clicks => total_unique_clicks,
                             :stats_updated_at => Time.now)

    self.reload
  end
  
  def stats_check
    update_stats if stats_updated_at.nil? || (stats_updated_at + STATS_CACHE.seconds) < Time.now
  end
  
  def total_hits 
     stats_check
     self['total_hits']
   end

   def total_unique_hits
     stats_check
     self['total_unique_hits']
   end

   def total_clicks
     stats_check
     self['total_clicks']
   end

   def total_unique_clicks
     stats_check
     self['total_unique_clicks']
   end
end
