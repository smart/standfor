class Avatar < ActiveRecord::Base
  belongs_to :account
  acts_as_attachment :storage => :file_system, 
		     :contentrlype => :image, :thumbnails => {  :normal => '300>', 
							 	:thumb => '75', 
								:medium => '150' }
  validates_as_attachment

end
