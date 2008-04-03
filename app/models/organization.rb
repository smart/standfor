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
   validates_presence_of :name, :keyword, :description
   acts_as_taggable
  
  def before_create
    @attributes['site_name'] = name.downcase.gsub(/\s+/, ' ').gsub(/[^a-zA-Z0-9_]+/, '-')
  end
  
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
    values = Donation.sum(:amount,
			      :group => :account_id,
			      :conditions => ["organization_id = ?", self.id], 
		              :order => "sum(amount) DESC "  )
    return nil if values.size == 0  
    id, value = values.first  
    return Account.find(id)
  end

  def top_donors(limit = 10)
    values = Donation.sum(:amount,
			  :group => :account_id, 
			  :conditions => ["organization_id = ?", self.id], 
		          :order => "sum(amount) DESC ",
			  :limit => limit )
    a = []
    values.each do |val|
    (id, amount)  = val
     account = Account.find(id)
     a << [account, amount ]
    end
    a 
  end

   def featured_badges
      Badge.find(:all, :conditions => ["organization_id = ? ", self.id ],  :limit => 3 )
   end
   
   def number_of_donors
     Donation.count(:id, :conditions => ["organization_id = ?", self.id ] )  
   end

   def number_of_badges
     Badge.count(:id, :conditions => ["organization_id = ?", self.id ] )  
   end
   
   def logo(size)
     !self.organizationslogo.nil? ? self.organizationslogo.public_filename(size) : "missing_avatar.jpg"
   end
   
end
