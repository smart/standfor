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

end
