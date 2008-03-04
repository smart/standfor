class MyBadge < ActiveRecord::Base
  STATS_CACHE = 500
  belongs_to :account
  belongs_to :badge
  attr_accessor :build_data, :access_code
  validates_presence_of :account_id
  has_many :sponsorship_hits
  has_many :sponsorship_clicks

 def validate_on_create
    unless self.available?(self.account) 
      errors.add(:badge_id, 'You have not met the authorization reqirements.' ) 
    end  
  end

  def available?(account)
     return self.badge.authorized?(account)
  end
 
  def after_create
    self.save_thumbnails
  end
  
  def adi
    Younety::Remote::Adi.find(adi_id)
  end
  
  def update_stats
    stats = Younety::Remote::Adi.find(adi_id).stats_summary
    self.update_attributes(:total_hits => stats['total_hits'], :total_clicks => stats['total_clicks'],
                           :total_unique_hits => stats['total_unique_hits'], :total_unique_clicks => stats['total_unique_clicks'],
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
  
  

  def all_sponsorships
   #refactor this into one SQL
     my_sponsors = []
     my_sponsors << self.badge.sponsorships
     my_sponsors << self.badge.segment.sponsorships
     my_sponsors << self.badge.segment.organization.sponsorships
     my_sponsors.flatten
  end

  def name
    self.badge.name
  end

  def organization 
    self.badge.organization
  end

  def segment 
    self.badge.segment
  end

   def source_path(opts = {})
      size = opts[:size] || 'full'
     "/images/cache/my_badges/#{self.id}/#{size}.gif"
   end

   def save_thumbnails
      remote_path = "#{ADISERVER}/adis/#{self.adi_id}.gif" 
      @file_data = open(remote_path) 
      image =  Magick::ImageList.new( @file_data.path  )
      full_path = File.join(File.join(self.cache_path , 'full.gif' ) ) 
      image.write(full_path)
      thumb = image.first.resize_to_fit(300, 300)
      thumb_path = File.join(File.join(self.cache_path , 'medium.gif' ) ) 
      thumb.write(thumb_path)
      small = image.first.resize_to_fit(225, 225)
      small_path = File.join(File.join(self.cache_path , 'small.gif' ) ) 
      small.write(small_path)
    end

   def cache_path
     dir = File.join(RAILS_ROOT, 'public', 'images', 'cache', 'my_badges' , self.id.to_s )
     FileUtils.mkdir(dir) unless File.exists?(dir)
     dir
   end

   def thumbnail_cache_path
     "/images/thumbnails/#{self.id}/" 
   end

   def minimum_donation
      self.badge.minimum_donation
   end

  def referred_accounts
    Account.find(:all, :conditions => ["my_badge_referrer = ?  ", self.id ] )
  end

  def referred_money_raised
    total = 0 
    self.referred_accounts.each do |ra|
      total +=   ra.total_donations 
    end
    total
  end

   protected
   def after_initialize
      if self.adi_id.nil?
    #self.adi_id = Adi.create(:product_key => self.badge.structure_id, :auth_enabled => false ).id if badge_id
        if badge_id
          adi = Younety::Remote::Adi.create(:product_key => self.badge.structure_id, :auth_enabled => false ) 
          self.adi_id = adi.id
          adi = Younety::Remote::Adi.find(self.adi_id) 
          self.public_adi_id = adi.attributes['public_id']
        end
      end
   end

end
