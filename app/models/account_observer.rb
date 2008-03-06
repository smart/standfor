class AccountObserver < ActiveRecord::Observer

  def after_save(account)
    Notification.deliver_forgot_password(account) if account.recently_forgot_password?
  end

end
