RSpec.describe UserMailer do
  describe ".password_reset" do
    let(:token) { Encryptor.generate_token }
    let(:user)  { create(:confirmed_user, reset_token: token[1]) }

    let(:mail) do
      described_class.password_reset(user)
    end

    it "sets the subject" do
      expect(mail.subject).to eq("Meet Meeples Password Reset")
    end

    it "sets the receiver email" do
      expect(mail.to).to eq([user.email])
    end

    it "sets the sender email" do
      expect(mail.from).to eq(["admin@meetmeeples.com"])
    end

    it "assigns @first_name" do
      expect(mail.body.encoded).to match(user.first_name)
    end
  end
end
