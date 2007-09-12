class MyBadge < ActiveRecord::Base
  belongs_to :account
  belongs_to :badge
  attr_accessor :build_data, :access_code

  validates_presence_of :account_id

  def validate_on_create
     unless self.badge.authorized?(self.account)
         errors.add(:badge_id, 'You have not met the authorization reqirements.' )
     else 
        adi = Adi.create(:product_key => self.badge.structure_id, 
		   	 :auth_enabled => false )
       if adi.id.nil?
          errors.add(:adi_id, "Your badge was not able to be created please check the form.")
        else
          self.adi_id  = adi.id
        end
      end
   end

end
