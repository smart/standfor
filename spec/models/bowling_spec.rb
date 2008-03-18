require File.dirname(__FILE__) + '/../spec_helper'

describe Bowling do
  before(:each) do
    @bowling = Bowling.new
  end

  it "should be valid" do
    @bowling.should be_valid
  end
end
