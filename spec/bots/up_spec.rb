require "spec_helper"

describe Flying::Bot::Up do
  subject { Flying::Bot::Up.new }
  
  context "up" do
    it "checks if site is up" do
      subject.stub(:get_http_response_code).and_return("302")
      subject.assess("http://www.google.com").should be_true
    end
  end
  
  context "down" do
    it "returns false if 404 and saves a message" do
      subject.stub(:get_http_response_code).and_return("404")
      subject.assess("http://www.google.com").should be_false
      subject.message.should == "http://www.google.com: The target was simply not found (404)."
    end
  end
end