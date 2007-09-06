class Segment < ActiveRecord::Base
   belongs_to :organization
   validates_presence_of :name, :keyword
end
