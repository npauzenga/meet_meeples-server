RSpec.describe DeleteModel do
  describe ".call" do
    let(:user) { create(:confirmed_user) }

    context "when successful" do
      subject do
        described_class.call(active_record_class: User, id: user.id)
      end

      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "deletes the user record" do
        expect(subject.model.destroyed?).to be_truthy
      end
    end

    context "when user id is not provided" do
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

    context "when active record class is not provided" do
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

    context "when destroy fails" do
      before do
        allow_any_instance_of(User).to receive(:destroyed?).and_return(false)
      end

      subject do
        described_class.call(active_record_class: User, id: user.id)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("model not deleted")
      end
    end
  end
end
