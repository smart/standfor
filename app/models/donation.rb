class Donation < ActiveRecord::Base
   belongs_to :account
   belongs_to :organization
   belongs_to :segment
   belongs_to :order

   attr_accessor :creditcard
   attr_accessor :confirmed
   attr_accessor :authorization
   attr_accessor :last_four

end
