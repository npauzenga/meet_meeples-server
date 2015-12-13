RSpec.describe UpdateUser do
  describe ".call" do
    let(:user) { create(:confirmed_user) }
    let(:user_params) do
      { user: {
        first_name: "John",
        email:      "test@test.com",
        last_name:  "Doe",
        city:       "Annapolis",
        state:      "MD",
        country:    "USA",
        password:   "helloworld" }
      }
    end

    context "when successful" do
      subject do
        described_class.call(user: user, params: user_params)
      end

      it "returns a successful context" do
        is_expected.to be_a_success
      end
    end

    context "when user is invalid" do
      subject do
        described_class.call(user: nil, params: user_params)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.error).to eq("invalid input")
      end
    end

    context "when user params are not provided" do
      subject do
        described_class.call(user: user, params: nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.error).to eq("invalid input")
      end
    end
  end
end
