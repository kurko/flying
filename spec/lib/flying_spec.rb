require "spec_helper"

describe Flying do
  context "regarding errors" do
    subject { Flying::Bot::Up.new("http://www.google.com") }
    
    it "no error happened" do
      subject.stub(:get_http_response_code).and_return("302")
      subject.assess.should be_true
      subject.error.should be_false
    end
  end
end