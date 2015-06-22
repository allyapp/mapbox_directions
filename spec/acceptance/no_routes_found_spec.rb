RSpec.describe "when calling directions with wrong options" do
  let(:options) do
    {
      access_token: "whatever",
      mode:         "driving",
      origin:       "52.12,13.2",
      destination:  "-77.03,38.91",
      geometry:     "polyline",
      alternatives: false,
      instructions: "text"
    }
  end
  let(:mode)       { "driving" }
  let(:directions) do
    VCR.use_cassette("no_routes_found") { MapboxDirections.directions(options) }
  end

  it "returns empty routes" do
    expect(directions.routes).to be_empty
  end

  it "returns an informative error" do
    expect(directions.error).to eq("Cannot find route between points")
  end
end
