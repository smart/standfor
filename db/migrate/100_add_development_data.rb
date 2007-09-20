class AddDevelopmentData  < ActiveRecord::Migration

     def self.up 
	if RAILS_ENV == 'development'

          @role = Role.create(:title => 'admin' )

 	  @campaign = Campaign.new 
 	  @campaign.name  = 'Cut for Life'
 	  @campaign.description = 'Help our 10,000th child.' 
 	  @campaign.segment_id = 1
 	  @campaign.admin_id = 1
 	  @campaign.goal =  1000000
 	  @campaign.end_date = Time.now  + 1.year
 	  @campaign.save 
        end
     end

end
