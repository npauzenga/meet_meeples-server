RSpec.describe UpdateModel do
  describe ".call" do
    let(:user) { create(:confirmed_user) }

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

    context "when successful" do
      subject do
        described_class.call(active_record_class: User,
                             id:                  user.id,
                             model_params:        user_params)
      end

      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "updates the user" do
        subject
        expect(User.find(user.id).first_name).to eq("John")
      end
    end

    context "when user_params is not provided" do
      subject do
        described_class.call(active_record_class: User, id: user.id)
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
        described_class.call(user_params: user_params, id: user.id)
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
        described_class.call(active_record_class: User,
                             user_params:         user_params)
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
        allow(User).to receive(:update).and_return(false)
      end

      subject do
        described_class.call(active_record_class: User,
                             id:                  user.id,
                             model_params:        user_params)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("update failed")
      end
    end
  end
end
