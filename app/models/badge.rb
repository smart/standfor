class Badge < ActiveRecord::Base
  belongs_to :organization
  has_many :requirements
  has_many :my_badges


  def authorized?(account)
    self.requirements.each do |req| 
	return true if req.met?(account)
    end
    return false 
  end

  def access_codes
    a = [] 
    self.requirements.find_all_by_type('CodeRequirement').each do |req|
        a << req.access_codes 
    end
    a.flatten
  end

  def requires_donation?
     DontationRequirement.exists?(:badge_id => self.id) 
  end

  def required_donation  
     requirement = DonationRequirement.find_by_badge_id(self.id) 
     requirement
  end

end
