RSpec.describe MapboxDirections::Client do
  let(:profile)     { "mapbox.driving" }
  let(:waypoints)   { "12,0.3;13,4.1" }
  let(:params_hash) { double(:params_hash) }
  let(:directions)  { described_class.new(double).directions }

  before do
    allow_any_instance_of(MapboxDirections::Parametizer).to receive(:profile) { profile }
    allow_any_instance_of(MapboxDirections::Parametizer).to receive(:waypoints) { waypoints }
    allow_any_instance_of(MapboxDirections::Parametizer).to receive(:params_hash) { params_hash }
  end

  describe "directions" do
    before do
      allow_any_instance_of(Faraday::Connection).to receive(:run_request)
    end

    it "calls with the right url and params returned by Parametizer" do
      url = "http://api.tiles.mapbox.com/v4/directions/#{profile}/#{waypoints}.json"
      expect_any_instance_of(Faraday::Connection).to receive(:get).with(url, params_hash)
      directions
    end
  end
end
