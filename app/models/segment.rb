class Segment < ActiveRecord::Base
   belongs_to :organization
   has_many :donations
   has_many :badges
   has_one :style_info, :as => :scope
   has_many :sponsorships, :as => :sponsorable 
   has_many :sponsors, :through => :sponsorships 
   acts_as_taggable

   validates_presence_of :name, :keyword, :description
  
  def self.find(*args)
    return (args[0].is_a?(String) ? self.find_by_site_name(*args) : super )
  end
  
  def before_create
    @attributes['site_name'] = name.downcase.gsub(/\s+/, ' ').gsub(/[^a-zA-Z0-9_]+/, '-')
  end
   
   def to_param
     "#{site_name}"
   end
end
