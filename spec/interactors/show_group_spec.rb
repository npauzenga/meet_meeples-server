RSpec.describe ShowGroup do
  describe ".call" do
    let(:group) { create(:group) }

    context "when successful" do
      subject do
        described_class.call(id: group.id)
      end

      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "returns a valid group record" do
        expect(subject.group).to be_a Group
      end
    end

    context "when invalid id is provided" do
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
  end
end
