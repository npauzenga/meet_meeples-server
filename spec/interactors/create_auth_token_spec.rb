RSpec.describe CreateAuthToken do
  describe ".call" do
    let(:user) { create(:unconfirmed_user) }

    subject do
      described_class.call(user: user)
    end

    context "when successful" do
      it "creates a new token" do
        expect(subject.token).to_not be_nil
      end
    end

    context "when user is not provided" do
      subject do
        described_class.call(user: nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end
    end
  end
end
