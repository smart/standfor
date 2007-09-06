class Organization < ActiveRecord::Base
  has_many :segments
  has_many :donations
  has_many :badges
end
