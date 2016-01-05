RSpec.describe CreatePasswordResetToken do
  describe ".call" do
    let(:user) { create(:confirmed_user) }

    context "when successful" do
      subject { described_class.call(user: user) }

      it "is a success" do
        is_expected.to be_a_success
      end

      it "sets the reset digest" do
        expect { subject }.to change(subject.user.reset_digest)
      end
    end

    context "when input is invalid" do
      it "fails" do
        is_expected.to be_a_failure
      end

      it "adds an error to errors" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when output is invalid" do
      it "fails" do
        is_expected.to be_a_failure
      end

      it "adds an error to errors" do
        expect(subject.errors).to eq("internal server error")
      end
    end
  end
end
