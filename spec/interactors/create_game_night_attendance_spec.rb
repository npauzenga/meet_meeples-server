RSpec.describe CreateGameNightAttendance do
  describe ".call" do
    let(:user)       { create(:confirmed_user) }
    let(:game_night) { create(:game_night) }

    subject do
      described_class.call(user_id: user.id, game_night_id: game_night.id)
    end

    context "when successful" do
      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "creates a new UserGameNightAttendance" do
        subject
        expect(user.game_nights.first).to eq(game_night)
      end
    end

    context "when UserGameNightAttendance is not persisted" do
      before do
        allow_any_instance_of(UserGameNightAttendance).to receive(:persisted?).
          and_return(false)
      end

      it "fails" do
        is_expected.to be_a_failure
      end
    end

    context "when user_id is not provided" do
      subject do
        described_class.call(game_night_id: game_night.id)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when game_night_id is not provided" do
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
