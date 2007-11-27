class MyBadge < ActiveRecord::Base
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
     "/images/cache/my_badges/#{self.id}/#{size}.jpg"
   end

   def save_thumbnails
      remote_path = "#{ADISERVER}/adis/#{self.adi_id}.jpg" 
      @file_data = open(remote_path) 
      image =  Magick::Image::read( @file_data.path  ).first
      full_path = File.join(File.join(self.cache_path , 'full.jpg' ) ) 
      image.write(full_path)
      thumb = image.resize_to_fit(300, 300)
      thumb_path = File.join(File.join(self.cache_path , 'medium.jpg' ) ) 
      thumb.write(thumb_path)
      small = image.resize_to_fit(225, 225)
      small_path = File.join(File.join(self.cache_path , 'small.jpg' ) ) 
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

   protected
   def after_initialize
      if self.adi_id.nil?
        self.adi_id = Adi.create(:product_key => self.badge.structure_id, :auth_enabled => false ).id if badge_id
      end
   end

end
