RSpec.describe UserMailer do
  describe ".password_reset" do
    let(:token) { Encryptor.generate_token }
    let(:user)  { create(:confirmed_user, reset_token: token[1]) }

    let(:mail) do
      UserMailer.password_reset(user: user)
    end

    it "renders the subject" do
      expect(mail.subject).to eq("Meet Meeples Password Reset")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq(user.email)
    end

    it "renders the sender email" do
      expect(mail.from).to eq("admin@meetmeeples.com")
    end

    it "assigns @reset_token" do
      expect(mail.body.encoded).to match(user.reset_token)
    end

    it "assigns @password_reset_url" do
      expect(mail.body.encoded).
        to match("http://www.meetmeeples.com/#{user.id}/password_reset")
    end
  end
end
