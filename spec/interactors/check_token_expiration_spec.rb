RSpec.describe CheckTokenExpiration do
  describe ".call" do
    context "when successful" do
      let(:user) do
        create(:confirmed_user, reset_sent_at: 1.hour.ago)
      end

      subject { described_class.call(sent_at: user.reset_sent_at) }

      it "is a success" do
        is_expected.to be_a_success
      end
    end

    context "when sent_at not provided" do
      subject { described_class.call(sent_at: nil) }

      it "is a failure" do
        is_expected.to be_a_failure
      end

      it "adds an error to errors" do
        expect(subject.errors).to eq("invalid token")
      end
    end

    context "when the token was sent more than a day ago" do
      let(:user) do
        create(:confirmed_user, reset_sent_at: (1.day + 1.hour).ago)
      end

      subject { described_class.call(sent_at: user.reset_sent_at) }

      it "is a failure" do
        is_expected.to be_a_failure
      end

      it "adds an error to errors" do
        expect(subject.errors).to eq("token expired")
      end
    end
  end
end
