class Organization < ActiveRecord::Base
  has_many :segments
  has_many :donations
  has_many :badges
  has_many :campaigns
  has_one :style_info, :as => :scope
  
  def self.find(*args)
    return (args[0].is_a?(String) ? self.find_by_site_name(*args) : super )
  end
  
  def to_param
  "#{site_name}"
  end
  
end
