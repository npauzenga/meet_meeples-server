RSpec.describe FindUserByEmail do
  describe ".call" do
    let(:user) { create(:confirmed_user) }
    subject { described_class.call(email: user.email) }

    context "when successful" do
      it "returns the correct user" do
        expect(subject.user).to eq(user)
      end
    end

    context "when input is invalid" do
      subject { described_class.call(email: nil) }

      it "fails" do
        is_expected.to be_a_failure
      end

      it "adds appropriate error to errors" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when output is invalid" do
      before do
        allow(User).to receive(:find_by).and_return(nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "adds appropriate error to errors" do
        expect(subject.errors).to eq("invalid user")
      end
    end
  end
end
