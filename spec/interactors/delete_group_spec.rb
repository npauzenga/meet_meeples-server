RSpec.describe DeleteGroup do
  describe ".call" do
    let(:group) { create(:group) }

    context "when successful" do
      subject do
        described_class.call(id: group.id)
      end

      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "deletes the group record" do
        expect(subject.group.destroyed?).to be_truthy
      end
    end

    context "when group id is invalid" do
      subject do
        described_class.call(id: nil)
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
        allow_any_instance_of(Group).to receive(:destroyed?).and_return(false)
      end

      subject do
        described_class.call(id: group.id)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("group not deleted")
      end
    end
  end
end
