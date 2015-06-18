RSpec.describe "when calling directions with wrong options" do
  let(:options) do
    {
      access_token: "whatever",
      mode:         mode,
      origin:       origin,
      destination:  "-77.03,38.91",
      geometry:     "polyline",
      alternatives: false,
      instructions: "text"
    }
  end
  let(:mode)       { "driving" }
  let(:directions) { MapboxDirections.directions(options) }
  let(:origin)     { "-122.42,38.78" }

  context "when the access_token is missing" do
    before do
      options.delete(:access_token)
    end

    it "raises MissingAccessTokenError" do
      expect { directions }.to raise_error(MapboxDirections::MissingAccessTokenError)
    end
  end

  context "when the transport mode is not supported" do
    let(:mode) { "horse" }

    it "raises UnsupportedTransportModeError" do
      expect { directions }.to raise_error(MapboxDirections::UnsupportedTransportModeError)
    end
  end

  context "when some of the coordinates is wrongly formatted" do
    let(:origin) { "-122.42878" }

    it "raises CoordinatesFormatError" do
      expect { directions }.to raise_error(MapboxDirections::CoordinatesFormatError)
    end
  end
end
