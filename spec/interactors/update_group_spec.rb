RSpec.describe UpdateGroup do
  describe ".call" do
    let(:group) { create(:group) }

    let(:group_params) do
      {
        name:     "Potter's Trotters",
        city:     "Baltimore",
        state:    "MD",
        country:  "USA",
        facebook: "http://facebook.com/weasley",
        twitter:  "http://twitter.com/weasley"
      }
    end

    context "when successful" do
      subject do
        described_class.call(id: group.id, group_params: group_params)
      end

      it "returns a successful context" do
        is_expected.to be_a_success
      end
    end

    context "when group_params is not provided" do
      subject do
        described_class.call(id: group.id)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when id is not provided" do
      subject do
        described_class.call(group_params: group_params)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when update fails" do
      before do
        allow(Group).to receive(:update).and_return(false)
      end

      subject do
        described_class.call(id: group.id, group_params: group_params)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("group update failed")
      end
    end
  end
end
