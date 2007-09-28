class SponsorshipClick < ActiveRecord::Base
  belongs_to :sponsorship
  belongs_to :my_badge
  belongs_to :sponsorship_hit
end
