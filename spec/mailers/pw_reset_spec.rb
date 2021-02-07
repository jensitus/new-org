require "rails_helper"

RSpec.describe PwResetMailer, type: :mailer do
  describe "send_pw_reset_info" do
    let(:mail) { PwResetMailer.send_pw_reset_info }

    it "renders the headers" do
      expect(mail.subject).to eq("Send pw reset info")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
