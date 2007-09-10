class Segment < ActiveRecord::Base
   belongs_to :organization
   belongs_to :donation
   validates_presence_of :name, :keyword
end
