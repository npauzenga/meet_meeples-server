RSpec.describe CreateGroupMembership do
  describe ".call" do
    let(:user) { create(:confirmed_user) }
    let(:group) { create(:group) }

    subject do
      described_class.call(user_id: user.id, group_id: group.id)
    end

    context "when successful" do
      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "creates a new UserGroupMembership" do
        subject
        expect(user.groups.first).to eq(group)
      end
    end

    context "when UserGroupMembership is not persisted" do
      before do
        allow_any_instance_of(UserGroupMembership).to receive(:persisted?).
          and_return(false)
      end

      it "fails" do
        is_expected.to be_a_failure
      end
    end

    context "when user_id is not provided" do
      subject do
        described_class.call(group_id: group.id)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when group_id is not provided" do
      subject do
        described_class.call(user_id: user.id)
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
