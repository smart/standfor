class Badge < ActiveRecord::Base
  belongs_to :organization
  belongs_to :segment
  has_many :requirements
  has_many :my_badges
  has_many :authorizations
  has_many :donations
  belongs_to :campaign
  has_many :sponsorships, :as => :sponsorable 
  has_many :sponsors, :through => :sponsorships 
  acts_as_taggable

  def authorized?(account)
    self.requirements.each do |req| 
	     return true if req.met?(account)
    end
    return false 
  end

  def to_param
   "#{id}"
  end

  def access_codes
    a = [] 
    self.requirements.find_all_by_type('CodeRequirement').each do |req|
        a << req.access_codes 
    end
    a.flatten
  end

  def requires_donation?
     DonationRequirement.exists?(:badge_id => self.id) 
  end

  def required_donation  
     requirement = DonationRequirement.find_by_badge_id(self.id) 
     requirement
  end

   def paid?
     Authorization.exists?(:badge_id  => self.id, :status => true )
   end

    def account_access(account) 
       return 'requiresLogin'  	if account == :false  
       return 'alreadyHas'  	if self.belongs_to?(account) 
       return 'needsDonation' 	if self.requires_donation?  and !(self.authorized?(account))   
       return 'badgeAvailable'    
    end

     def belongs_to?(account)
	return MyBadge.exists?(:account_id => account.id, :badge_id  => self.id )
     end 

    def source_path(opts = {})
    	size = opts[:size] || 'full'
      "/images/examples/#{self.id}/#{size}.gif"
    end

    def example_path
      "/images/examples/#{self.id}.gif"
    end

    def total_hits
      "not implemented"
    end

    def unique_hits
      "not implemented"
    end

    def number_of_instances
      MyBadge.count(:conditions => [ "badge_id = ? ",  self.id ] )
    end

     def users     
       Account.find(:all, :conditions =>  ["id IN ( SELECT account_id FROM my_badges WHERE badge_id = ? ) ",  self.id ] )
     end

     def minimum_donation
          @donation_requirement = self.requirements.find_by_type('DonationRequirement')
          return @donation_requirement.value.to_i if !@donation_requirement.nil?
          return 0
     end

   def source_path(opts = {})
      size = opts[:size] || 'full'
     "/images/cache/badges/#{self.id}/#{size}.gif"
   end

   def save_thumbnails
      structure = Younety::Remote::Structure.find(self.structure_id)
      remote_path = "#{ADISERVER}/adis/#{structure.example_adi_id}.gif" 
      @file_data = open(remote_path) 
      image =  Magick::Image::read( @file_data.path  ).first
      full_path = File.join(File.join(self.cache_path , 'full.gif' ) ) 
      image.write(full_path)
      thumb = image.resize_to_fit(300, 300)
      thumb_path = File.join(File.join(self.cache_path , 'medium.gif' ) ) 
      thumb.write(thumb_path)
      small = image.resize_to_fit(225, 225)
      small_path = File.join(File.join(self.cache_path , 'small.gif' ) ) 
      small.write(small_path)
   end

   def cache_path
     dir = File.join(RAILS_ROOT, 'public', 'images', 'cache', 'badges' , self.id.to_s )
     FileUtils.mkdir_p(dir) unless File.exists?(dir)
     dir
   end

   def referred_accounts
     Account.find(:all,:conditions=>["my_badge_referrer IN (SELECT id FROM my_badges WHERE badge_id = ? )", self.id ])
   end

  def self.featured
    find_by_featured(true, :order => 'RAND()', :limit => 1)
  end

end
