RSpec.describe IndexProfile do
  describe ".call" do
    subject do
      described_class.call
    end

    let!(:user1) { create(:confirmed_user) }
    let!(:user2) { create(:confirmed_user) }
    let!(:user3) { create(:confirmed_user) }

    context "when successful" do
      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "sets profiles to an array of users" do
        expect(subject.profiles).to eq([user1, user2, user3])
      end
    end

    context "when unsuccessful" do
      before do
        allow(User).to receive(:all).and_return(nil)
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
