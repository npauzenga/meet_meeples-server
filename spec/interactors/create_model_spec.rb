RSpec.describe CreateModel do
  describe ".call" do
    let(:user_params) do
      {
        first_name: "John",
        email:      "test@test.com",
        last_name:  "Doe",
        city:       "Annapolis",
        state:      "MD",
        country:    "USA",
        password:   "helloworld"
      }
    end

    subject do
      described_class.call(active_record_class: User, model_params: user_params)
    end

    context "when successful" do
      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "creates a new model" do
        expect(subject.model).to be_a User
      end
    end

    context "when model is not saved" do
      before do
        user_params["first_name"] = nil
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors.messages).to eq(first_name: ["can't be blank"])
      end
    end

    context "when model_params is not provided" do
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

    context "when active_record_class is not provided" do
      subject do
        described_class.call(model_params: user_params)
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
