class AccountBadgeAuthorization < ActiveRecord::Base
   belongs_to :account
   belongs_to :badge
   belongs_to :badge_access_code
end
