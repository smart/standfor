class Organization < ActiveRecord::Base
  has_many :segments
  has_many :donations
  has_many :badges
  has_many :campaigns
  has_one :style_info, :as => :scope
end
