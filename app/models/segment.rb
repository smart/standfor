class Segment < ActiveRecord::Base
   belongs_to :organization
   has_many :donations
   has_many :badges
   validates_presence_of :name, :keyword
end
