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
     else 
        adi = Adi.create(:product_key => self.badge.structure_id, :auth_enabled => false )
       if adi.id.nil?
          errors.add(:adi_id, "Your badge was not able to be created please check the form.")
        else
          self.adi_id  = adi.id
        end
      end
   end

  def available?(account)
     return self.badge.authorized?(account)
 end

   def all_sponsorships
   #refactor this into one SQL
     my_sponsors = []
     my_sponsors << self.badge.sponsorships
     my_sponsors << self.badge.segment.sponsorships
     my_sponsors << self.badge.segment.organization.sponsorships
     my_sponsors.flatten
   end

   protected
   def after_initialize
     p '======================================'
     p '======================================'
     p  'called......'
     p '======================================'
     p '======================================'
    self.adi_id = Adi.create(:product_key => self.badge.structure_id, :auth_enabled => false).id if self.adi_id.nil?
   end
   

end
