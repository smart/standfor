class Notification < ActionMailer::Base
 
   def forgot_password(account)
      content_type 'text/plain'
      @recipients = account.primary_email.strip 
      @subject    = 'Request to change your password'
      @body =  {
          :url => "#{STANDFOR_ROOT}/reset/password/#{account.reset_password_code}" ,
          :user => account.primary_email 
      }
  end

end
