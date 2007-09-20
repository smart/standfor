class Campaign < ActiveRecord::Base
   belongs_to :segment
   has_one :badge
   belongs_to :admin, :foreign_key => 'admin_id', :class_name => 'Account' 

   validates_numericality_of :goal
   validates_presence_of :goal, :name, :description, :admin_id


   def organization
     self.segment.organization
   end

end
