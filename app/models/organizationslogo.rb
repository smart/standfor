class Organizationslogo < ActiveRecord::Base
  belongs_to :organization
  acts_as_attachment :storage => :file_system, 
		     :content_type => :image, :thumbnails => { :normal => '300>', :thumb => '75' }
  validates_as_attachment

 def to_param
   "#{id}"
 end

end
