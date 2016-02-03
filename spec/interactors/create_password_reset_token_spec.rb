RSpec.describe CreatePasswordResetToken do
  describe ".call" do
    let(:user) { create(:confirmed_user) }

    context "when successful" do
      subject { described_class.call(user: user) }

      it "is a success" do
        is_expected.to be_a_success
      end

      it "sets the reset digest" do
        expect { subject }.to change { user.reset_digest }
      end

      it "sets the reset digest to a string" do
        expect(subject.user.reset_digest).to be_a(String)
      end
    end

    context "when user is not valid" do
      subject { described_class.call(user: nil) }

      it "fails" do
        is_expected.to be_a_failure
      end

      it "adds an error to errors" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when update fails" do
      subject { described_class.call(user: user) }

      before do
        allow(user).to receive(:update).and_return(false)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "adds an error to errors" do
        expect(subject.errors).to eq("server error")
      end
    end
  end
end
