RSpec.describe SendPasswordResetEmail do
  describe ".call" do
    let(:token) { Encryptor.generate_token }

    let(:user) do
      create(:confirmed_user, reset_digest: token[0],
                              reset_token:  token[1])
    end

    subject(:send_email) do
      described_class.call(user: user)
    end

    before do
      ActionMailer::Base.deliveries.clear
    end

    context "when successful" do
      it "is a success" do
        is_expected.to be_a_success
      end

      it "sends an email" do
        send_email
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end

    context "when user not provided" do
      subject(:send_email) do
        described_class.call(user: nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "adds an error to errors" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when user does not have a valid reset_digest" do
      let(:user) do
        create(:confirmed_user, reset_digest: nil,
                                reset_token:  token[1])
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "adds an error to errors" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when user does not have a valid reset_token" do
      let(:user) do
        create(:confirmed_user, reset_digest: token[0],
                                reset_token:  nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "adds an error to errors" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when send fails" do
      it "fails" do
        is_expected.to be_a_failure
      end

      it "adds an error to errors" do
        expect(subject.errors).to eq("invalid output")
      end
    end
  end
end
