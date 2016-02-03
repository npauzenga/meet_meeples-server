RSpec.describe IndexGroup do
  describe ".call" do
    subject do
      described_class.call
    end

    let!(:group1) { create(:group) }
    let!(:group2) { create(:group) }
    let!(:group3) { create(:group) }

    context "when successful" do
      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "sets profiles to an array of groups" do
        expect(subject.groups).to eq([group1, group2, group3])
      end
    end

    context "when unsuccessful" do
      before do
        allow(Group).to receive(:all).and_return(nil)
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
