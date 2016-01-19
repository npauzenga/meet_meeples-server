RSpec.describe InvalidParamsError do
  let(:error_hash) do
    {
      title:   "Invalid Params",
      code:    :invalid_params,
      details: "One or more of the parameters was missing or failed valiation."
    }
  end

  subject do
    InvalidParamsError.new
  end

  describe "attributes" do
    it "has a title" do
      expect(subject.title).to eq("Invalid Params")
    end

    it "has a code" do
      expect(subject.code).to eq(:invalid_params)
    end

    it "has details" do
      expect(subject.details).
        to eq("One or more of the parameters was missing or failed valiation.")
    end
  end
end
