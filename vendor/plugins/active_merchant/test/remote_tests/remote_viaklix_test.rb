require File.dirname(__FILE__) + '/../test_helper'

class RemoteViaklixTest < Test::Unit::TestCase
  include ActiveMerchant::Billing
  
  LOGIN = 'YOUR MERCHANT ID'
  USER = 'YOUR USER ID'
  PIN = 'YOUR PIN'

  def setup
    @gateway = ViaklixGateway.new(
      :login => LOGIN,
      :password => PIN,
      :user => USER
    )
    
    @credit_card = credit_card('4242424242424242')
    
    @bad_credit_card = credit_card('invalid')
    
    @options = {
      :order_id => '#1000.1',
      :email => "paul@domain.com",   
      :description => 'Test Transaction',
      :address => { 
         :address1 => '164 Waverley Street', 
         :address2 => 'APT #7', 
         :country => 'US', 
         :city => 'Boulder', 
         :state => 'CO', 
         :zip => '12345'
      }     
    }
  end
  
  def test_successful_purchase
    assert response = @gateway.purchase(100, @credit_card, @options)
    
    assert response.success?
    assert response.test?
    assert_equal 'APPROVED', response.message
    assert response.authorization
  end
  
  def test_failed_purchase
    assert response = @gateway.purchase(100, @bad_credit_card, @options)
  
    assert !response.success?
    assert response.test?
    assert_equal 'The Credit Card Number supplied in the authorization request appears invalid.', response.message
  end
  
  def test_credit
    assert purchase = @gateway.purchase(100, @credit_card, @options)
    assert purchase.success?
    
    assert credit = @gateway.credit(100, @credit_card)
    assert credit.success?
  end
end