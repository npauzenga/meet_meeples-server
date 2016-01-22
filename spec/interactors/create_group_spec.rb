RSpec.describe CreateGroup do
  describe ".call" do
    let(:params) { { group: interactor_input.fetch(:user_params) } }

    let(:group_params) do
      {
        name:     "Weasley's Kneesleys",
        city:     "Baltimore",
        state:    "MD",
        country:  "USA",
        facebook: "http://facebook.com/weasley",
        twitter:  "http://twitter.com/weasley"
      }
    end

    subject do
      described_class.call(group_params: group_params)
    end

    context "when successful" do
      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "creates a new user" do
        expect(subject.group).to be_a Group
      end
    end

    context "when group is not saved" do
      before do
        group_params["name"] = ""
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors.messages).to eq(name: ["can't be blank"])
      end
    end

    context "when invalid input is provided" do
      subject do
        described_class.call(group_params: nil)
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
