class Organization < ActiveRecord::Base
   has_many :segments
   has_many :donations
   has_many :badges
   has_many :campaigns
   has_one :segment
   has_one :style_info, :as => :scope
   has_one :organizationslogo
   has_many :sponsorships, :as => :sponsorable 
   has_many :sponsors, :through => :sponsorships 
   validates_presence_of :name, :keyword, :description, :site_name
   acts_as_taggable
  
  def self.find(*args)
    return (args[0].is_a?(String) ? self.find_by_site_name(*args) : super )
  end
  
  def to_param
  "#{site_name}"
  end
 
  def total_raised
    0 + Donation.sum(:amount,  :conditions => ["organization_id = ? " , self.id ] ).to_i
  end
  
  def top_sponsor
    values = Donation.maximum(:amount,:group => :account_id,:conditions => ["organization_id = ?", self.id] )
    return nil if values.size == 0  
    id, value = values.first  
    return Account.find(id)
  end

   def featured_badges
      Badge.find(:all, :conditions => ["organization_id = ? ", self.id ],  :limit => 3 )
   end
   
end
