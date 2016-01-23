RSpec.describe ShowModel do
  describe ".call" do
    let(:user) { create(:confirmed_user) }

    context "when successful" do
      subject do
        described_class.call(active_record_class: User,
                             id:                  user.id)
      end

      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "returns a valid user record" do
        expect(subject.model).to be_a User
      end
    end

    context "when id is not provided" do
      subject do
        described_class.call(active_record_class: User)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when active_record_model is not provided" do
      subject do
        described_class.call(id: user.id)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("invalid input")
      end
    end
  end
end
