RSpec.describe AddRoleToUser do
  describe ".call" do
    let(:user) { create(:confirmed_user) }
    let(:group) { create(:group) }
    let(:role) { :moderator }

    subject do
      described_class.call(user: user, resource: group, role: role)
    end

    context "when successful" do
      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "adds the appropriate role to user" do
        expect(subject.user.has_role? role, group).to be_truthy
      end
    end

    context "when user is not provided" do
      subject do
        described_class.call(user: nil, resource: group, role: role)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when resource is not provided" do
      subject do
        described_class.call(user: user, resource: nil, role: role)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when role is not provided" do
      subject do
        described_class.call(user: user, resource: group, role: nil)
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
