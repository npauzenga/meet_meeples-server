RSpec.describe ShowUser do
  describe ".call" do
    let(:user) { create(:confirmed_user) }

    context "when successful" do
      subject do
        ShowUser.call(id: user.id)
      end

      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "returns a valid user record" do
        expect(subject.user).to be_a User
      end
    end

    context "when invalid id is provided" do
      subject do
        ShowUser.call(id: nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.error).to eq("invalid user id")
      end
    end

    context "when user output is invalid" do
      subject do
        ShowUser.call(id: 0)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.error).to eq("invalid user")
      end
    end
  end
end
