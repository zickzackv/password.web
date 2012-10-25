require "spec_helper"

describe UserMailer do
  describe "assignment" do
    let(:mail) { UserMailer.assignment }

    it "renders the headers" do
      mail.subject.should eq("Assignment")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
