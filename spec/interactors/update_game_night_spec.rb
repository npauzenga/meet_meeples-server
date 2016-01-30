RSpec.describe UpdateGameNight do
  describe ".call" do
    let(:game_night) { create(:game_night) }

    let(:game_night_params) do
      {
        time:             DateTime.new.utc,
        name:             "Space Hulk Tournament",
        location_name:    "The library",
        location_address: "123 fake st"
      }
    end

    context "when successful" do
      subject do
        described_class.call(id:                game_night.id,
                             game_night_params: game_night_params)
      end

      it "returns a successful context" do
        is_expected.to be_a_success
      end
    end

    context "when game_night_params is not provided" do
      subject do
        described_class.call(id: game_night.id)
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
        described_class.call(game_night_params: game_night_params)
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
        allow(GameNight).to receive(:update).and_return(false)
      end

      subject do
        described_class.call(id:                game_night.id,
                             game_night_params: game_night_params)
      end

      it "fails" do
        is_expected.to be_a_failure
      end

      it "returns an error" do
        expect(subject.errors).to eq("game_night update failed")
      end
    end
  end
end
