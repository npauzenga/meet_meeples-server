RSpec.describe UpdatePassword do
  describe ".call" do
    let(:user)        { create(:confirmed_user) }
    let(:password)    { "newpassword" }

    context "when successful" do
      subject do
        described_class.call(user: user, password: password)
      end

      it "sets the user's reset digest to nil" do
        user.reset_digest = "resetdigest"
        expect(subject.user.reset_digest).to be_nil
      end

      it "updates the user's password" do
        expect(subject.user.password).to eq("newpassword")
      end

      it "updates the user's password digest" do
      end
    end

    context "when user not provided" do
      subject do
        described_class.call(password: password)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when user password  not provided" do
      subject do
        described_class.call(user: user)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when update fails" do
      subject do
        described_class.call(password: password, user: user)
      end

      before do
        allow(user).to receive(:update).and_return(false)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("internal server error")
      end
    end
  end
end
