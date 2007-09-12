class Segment < ActiveRecord::Base
   belongs_to :organization
   has_many :donations
   validates_presence_of :name, :keyword
end
