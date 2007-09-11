module AuthenticatedTestHelper
  # Sets the current account in the session from the account fixtures.
  def login_as(account)
    @request.session[:account] = account ? accounts(account).id : nil
  end

  def authorize_as(user)
    @request.env["HTTP_AUTHORIZATION"] = user ? "Basic #{Base64.encode64("#{users(user).login}:test")}" : nil
  end
end