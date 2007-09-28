class SponsorshipHit < ActiveRecord::Base
  belongs_to :sponsorship
  belongs_to :my_badge
end
