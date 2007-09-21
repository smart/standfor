class Organization < ActiveRecord::Base
  has_many :segments
  has_many :donations
  has_many :badges
  has_many :campaigns
  #has_many :campaigns, :through  => :segments 
end
