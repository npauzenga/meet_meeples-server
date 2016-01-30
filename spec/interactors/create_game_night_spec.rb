RSpec.describe CreateGameNight do
  describe ".call" do
    let(:user) { create(:confirmed_user) }

    let(:game_night_params) do
      {
        time:             DateTime.new.utc,
        name:             "Space Hulk Tournament",
        location_name:    "The library",
        location_address: "123 fake st"
      }
    end

    subject do
      described_class.call(user: user, game_night_params: game_night_params)
    end

    context "when successful" do
      it "returns a successful context" do
        is_expected.to be_a_success
      end

      it "creates a new game_night" do
        expect(subject.game_night).to be_a GameNight
      end
    end

    context "when game_night is not saved" do
      before do
        game_night_params["time"] = nil
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors.messages).to eq(time: ["can't be blank"])
      end
    end

    context "when params not provided" do
      subject do
        described_class.call(game_night_params: nil)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("invalid input")
      end
    end

    context "when user not provided" do
      subject do
        described_class.call(game_night_params: game_night_params)
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
