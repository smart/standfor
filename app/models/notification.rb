class Notification < ActionMailer::Base
 
   def forgot_password(account)
      content_type 'text/plain'
      @from = 'admin@standfor.us'
      @recipients = account.primary_email.strip
      @subject    = 'Request to change your password'
      @body =  {
          :url => "#{STANDFOR_ROOT}/reset/password/#{account.reset_password_code}" ,
          :user => account.primary_email 
      }
  end

   def donation_receipt(order)
      content_type 'text/plain'
      @from = 'admin@standfor.us'
      @recipients = account.primary_email.strip
      @subject    = 'donation receipt'
      @body =  {
          :user => order.account.primary_email 
          :amount => order.amount
      }
  end

end

