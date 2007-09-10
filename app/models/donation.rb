class Donation < ActiveRecord::Base
   belongs_to :account
   belongs_to :organization
   has_one :segment
end
