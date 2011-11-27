require "spec_helper"

describe Flying do
  context "regarding errors" do
    subject { Flying::Bot::Up.new }
    it "no error happened" do
      subject.stub(:get_http_response_code).and_return("302")
      subject.assess("http://www.google.com").should be_true
      Flying.an_error_ocurred.should be_false
    end
  end
end