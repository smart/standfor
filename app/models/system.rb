class System

   def self.total_donations
     Donation.sum(:amount) 
   end

   def self.total_number_of_donations
     Donation.count(:all) 
   end

   def self.total_number_of_badges
     Badge.count(:all) 
   end

   def self.total_number_of_accounts
     Account.count(:all) 
   end

   def self.total_number_of_user_badges
     MyBadge.count(:all) 
   end

   def self.badges(limit = nil)
      Badge.find(:all) if limit.nil?
      Badge.find(:all, :limit => limit ) 
   end

  def self.top_donors( limit = 10 )
    a = []
    Donation.sum(:amount, :group => :account_id, :order => "sum(amount) DESC ", :limit => limit ).each do |val|
      (id, amount)  = val
      account = Account.find(id)
      a << [account, amount ]
    end
    a 
  end

end
