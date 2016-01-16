RSpec.describe FindUserByResetToken do
  describe ".call" do
    let(:token) { Encryptor.generate_token }

    context "when successful" do
      let!(:user) { create(:confirmed_user, reset_digest: token[0]) }

      subject do
        described_class.call(reset_token: token[1])
      end

      it "is a success" do
        is_expected.to be_a_success
      end

      it "find the user" do
        expect(subject.user).to eq(user)
      end
    end

    context "when reset token not provided" do
      before do
        create(:confirmed_user, reset_digest: token[0])
      end

      subject do
        described_class.call(reset_token: nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "adds an error to errors" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when user not found" do
      before do
        create(:confirmed_user, reset_digest: "differenttoken")
      end

      subject do
        described_class.call(reset_token: token[1])
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "adds an error to errors" do
        expect(subject.errors).to eq("invalid output")
      end
    end
  end
end
