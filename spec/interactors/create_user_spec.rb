RSpec.describe CreateUser do
  describe ".call" do
    let(:params) { { user: interactor_input.fetch(:user_params) } }

    let(:user_params) do
      {
        first_name: "John",
        email: "test@test.com",
        last_name: "Doe",
        city: "Annapolis",
        state: "MD",
        country: "USA",
        password: "helloworld"
      }
    end

    subject do
      CreateUser.call(user_params: user_params)
    end

    context "when successful" do
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
        expect(subject.error).to eq("invalid user")
      end
    end

    context "when invalid input is provided" do
      subject do
        CreateUser.call(user_params: nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.error).to eq("invalid user params")
      end
    end
  end
end
