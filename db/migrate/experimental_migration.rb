class AddDevelopmentData  < ActiveRecord::Migration

     def self.up 
	if RAILS_ENV == 'development'
          @account = Account.new
          @account.fullname = 'Elliott Blatt' 
          @account.nickname = 'elmo' 
	  @account.phone = '8006665555'
	  @account.address_1 = 'line one' 
	  @account.address_2 = 'line two' 
 	  @account.city = 'New York'
	  @account.state = "NY"
	  @account.zip = '11211'
	  @account.country = 'USA' 
          @account.save 
          @role = Role.create(:title => 'admin' )
          @account.roles << @role

          @organization = Organization.new	
	  @organization.name = 'Gift Of Life' 
	  @organization. address1 = 'Address Line One'
	  @organization.address2  = 'Address Line Two'
	  @organization.address3 = 'Address Line Three'
 	  @organization.city= 'New York'
	  @organization.state= 'NY'
	  @organization.zip= '02138'
	  @organization.country= 'USA'
	  @organization.phone= '2121121111'
	  @organization.fax= '2121121111'
	  @organization.email= 'giftoflife@gol.org'
	  @organization.url= 'http://www.giftoflife.com'
	  @organization.statement= 'Helping Childen one at time.'
	  @organization.description= 'New York based charity comitted to getting medical care to children.'
	  @organization.keyword= 'children'
	  @organization.site_name= 'giftoflie'
          @organization.save

          @segment = Segment.new
          @segment.name = 'General Fund' 
          @segment.organization_id = @organization.id 
          @segment.keyword = 'children' 
          @segment.site_name = 'general' 
          @segment.description = 'Help support our general fund.' 
          @segment.save

          @badge = Badge.new
          @badge.name = 'Gift of Life Awareness'
          @badge.organization_id = @organization.id 
          @badge.segment_id = @segment.id 
          @badge.structure_id = 1 
          @badge.campaign_id = 1 
          @badge.description = 'Raise awareness about Gift of Life' 
          @badge.save 

          @requirement = CodeRequirement.new
          @requirement.badge_id = @badge.id 
          @requirement.name = "#{@badge.name} access code requiremed" 
          @requirement.description = "Please enter your access code." 
          @requirement.value = "abcde" 
          @requirement.save

          @access_code = AccessCode.new
          @access_code.scope_id = @requirement.id
          @access_code.scope_type  = 'Requirement' 
          @access_code.value  = @requirement.value
          @access_code.save

          @requirement = DonationRequirement.new
          @requirement.badge_id = @badge.id 
          @requirement.name = "#{@badge.name} donation requirement" 
          @requirement.description = "This badge requires a donation to #{@badge.organization.name}" 
          @requirement.value = "100" 
          @requirement.save


          @segment = Segment.new
          @segment.name = 'Cut For Life' 
          @segment.organization_id = @organization.id 
          @segment.keyword = 'children' 
          @segment.site_name = 'cutforlife' 
          @segment.description = 'Raise funds for our 10,000 child.' 
          @segment.save

          @badge = Badge.new
          @badge.name = 'Support the Cut For Life'
          @badge.organization_id = @organization.id 
          @badge.segment_id = @segment.id 
          @badge.structure_id = 1 
          @badge.campaign_id = 1 
          @badge.description = 'Support the Cut of Life' 
          @badge.save 

          @requirement = CodeRequirement.new
          @requirement.badge_id = @badge.id 
          @requirement.name = "#{@badge.name} access code requirement" 
          @requirement.description = "Please enter your access code." 
          @requirement.value = "wxyz" 
          @requirement.save

          @access_code = AccessCode.new
          @access_code.scope_id = @requirement.id
          @access_code.scope_type  = 'Requirement' 
          @access_code.value  = @requirement.value
          @access_code.save

          @requirement = DonationRequirement.new
          @requirement.badge_id = @badge.id 
          @requirement.name = "#{@badge.name} donation requirement" 
          @requirement.description = "This badge requires a donation to #{@badge.organization.name}" 
          @requirement.value = "100" 
          @requirement.save

 	  @campaign = Campaign.new 
 	  @campaign.name  = 'Cut for Life'
 	  @campaign.description = 'Help our 10,000th child.' 
 	  @campaign.segment_id = 1
 	  @campaign.admin_id = @account.id 
 	  @campaign.goal =  1000000
 	  @campaign.end_date = Time.now  + 1.year
 	  @campaign.save 

        end
     end

end
