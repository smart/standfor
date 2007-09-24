class Segment < ActiveRecord::Base
   belongs_to :organization
   has_many :donations
   has_many :badges
   has_many :campaigns
   validates_presence_of :name, :keyword
   has_one :style_info, :as => :scope
  
  def self.find(*args)
    return (args[0].is_a?(String) ? self.find_by_site_name(*args) : super )
  end 
   
   def to_param
     "#{site_name}"
   end
end
