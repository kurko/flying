require "spec_helper"

describe Flying::Bot::Up do
  context "initializing" do
    it "sets an alias" do
      bot = Flying::Bot::Up.new("http://www.google.com", :as => :google)
      bot.name.should == :google
    end

    it "has a service as dependency" do
      bot = Flying::Bot::Up.new("http://www.google.com", :depends_on => :google)
      bot.dependency.should include(:google)

      bot = Flying::Bot::Up.new("http://www.google.com", :depends_on => [:google, :fedex] )
      bot.dependency.should include(:google)
      bot.dependency.should include(:fedex)
    end
  end
  
  context "assessing" do
    subject { Flying::Bot::Up.new("http://www.google.com") }

    it "checks if site is up" do
      subject.stub(:get_http_response_code).and_return("302")
      subject.assess.should be_true
    end

    it "returns false if 404 and saves a message" do
      subject.stub(:get_http_response_code).and_return("404")
      subject.assess.should be_false
      subject.message.should =~ /google\.com.*target was simply not found \(404\)/
    end
  end
end