RSpec.describe "directions" do
  let(:options) do
    {
      access_token: "whatever",
      mode:         "driving",
      origin:       "-122.42,37.78",
      destination:  "-77.03,38.91",
      geometry:     geometry,
      alternatives: false,
      instructions: "text"
    }
  end
  let(:geometry) { "polyline" }

  let(:directions) do
    VCR.use_cassette(cassette) { MapboxDirections.directions(options) }
  end

  describe "success response when" do
    context "polyline as geometry" do
      let(:cassette) { "driving_polyline_as_geometry" }
      let(:geometry) { "polyline" }

      it "" do
        directions
      end
    end

    context "geojson as geometry" do
      let(:cassette) { "driving_geojson_as_geometry" }
      let(:geometry) { "geojson" }

      it "" do
        directions
      end
    end
  end

  context "failure response when" do
    let(:cassette) { "unauthorized" }

    it "" do
      directions
    end
  end
end
