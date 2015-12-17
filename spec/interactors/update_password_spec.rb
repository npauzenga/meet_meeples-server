RSpec.describe UpdatePassword do
  describe ".call" do
    let(:user)        { create(:confirmed_user) }
    let(:user_params) { { password: "newpassword" } }

    context "when successful" do
      subject do
        described_class.call(user_params: user_params, user: user)
      end

      it "sets the user's reset digest to nil" do
        user.reset_digest = "resetdigest"
        expect(subject.user.reset_digest).to be_nil
      end

      it "updates the user's password" do
        expect(subject.user.password).to eq("newpassword")
      end

      it "updates the user's password salt" do
        is_expected.to change(user.password_salt)
      end

      it "updates the user's password hash" do
        is_expected.to change(user.password_hash)
      end
    end

    context "when user not provided" do
      subject do
        described_class.call(user_params: user_params, user: nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.error).to eq("invalid user")
      end
    end

    context "when user params not provided" do
      subject do
        described_class.call(user_params: nil, user: user)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.error).to eq("invalid password")
      end
    end

    context "when update fails" do
      subject do
        described_class.call(user_params: user_params, user: user)
      end

      before do
        allow(user).to receive(:update_attributes).and_return(false)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.error).to eq("there was a problem saving the user")
      end
    end
  end
end
