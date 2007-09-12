class Donation < ActiveRecord::Base
   belongs_to :account
   belongs_to :organization
   belongs_to :segment
   belongs_to :badge
end
