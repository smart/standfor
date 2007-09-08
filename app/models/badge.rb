class Badge < ActiveRecord::Base
  belongs_to :organization
  has_many :requirements
  has_many :my_badges
  has_many :badge_access_codes
  has_many :account_badge_authorizations

  def authorized?(account)
    self.requirements.each do |req| 
	return true if req.met?(account)
    end
    return false 
  end

end
