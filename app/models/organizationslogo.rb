class Organizationslogo < ActiveRecord::Base
  belongs_to :organization
  acts_as_attachment :storage => :file_system, 
		            :content_type => :image, :thumbnails => {  :normal => '300>', :thumb => '75', :medium => '150' }
  validates_as_attachment

  
 def self.thumbnails
    find(:all, :conditions => "parent_id is null" )
 end


 def to_param
   "#{id}"
 end

end
