class Avatar < ActiveRecord::Base
  belongs_to :account
  acts_as_attachment :storage => :file_system, 
		     :content_type => :image, :thumbnails => {  :normal => '300>', 
							 	:thumb => '75', 
								:medium => '150' }
  validates_as_attachment

end
