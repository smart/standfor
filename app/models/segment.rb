class Segment < ActiveRecord::Base
   belongs_to :organization
   has_many :donations
   has_many :badges
   has_many :campaigns
   validates_presence_of :name, :keyword
end
