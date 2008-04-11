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
     Account.count(:all) - 1 
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
      next if account.roles.size > 0 and account.roles.first.id == 1
      a << [account, amount ]
    end
    a 
  end
 
  def self.most_badge_views(limit = 10)
    a = []
    Account.active_users.each do |account|
      begin
        a << [account, account.total_hits]
      rescue
        next
      end
    end
    a.sort!{|x,y| y[1] <=> x[1]}[0..10]
  end

  def self.most_referred_money_raised(limit = 10)
     money = {}
     Account.active_users.each do |account|
      money[account.id] = account.referred_money_raised
     end
     sorted = money.sort {|a,b| a[1] <=> b[1] }
     limit = sorted.size  if sorted.size < limit
     results = []
     sorted.slice(limit * -1 , limit).reverse.each do |account_id, amount|
       account = Account.find(account_id) 
       results << [account, amount]
     end
     results
  end

end
