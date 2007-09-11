class Authorization < ActiveRecord::Base
   attr_accessor :first_name, :last_name, :card_type, :number, :verification_value 
   belongs_to :badge
   belongs_to :account
end
