RSpec.describe CreateUser do
  describe ".call" do
    let(:params) { { user: interactor_input.fetch(:user_params) } }

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
      described_class.call(user_params: user_params)
    end

    context "when successful" do
      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "creates a new user" do
        expect(subject.user).to be_a User
      end
    end

    context "when user is not saved" do
      before do
        user_params[:email] = "invalid"
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors.messages).to eq(email: ["is invalid"])
      end
    end

    context "when invalid input is provided" do
      subject do
        described_class.call(user_params: nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq(CreateUser: "invalid Interactor input")
      end
    end
  end
end
