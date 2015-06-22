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
    let(:url) { "http://api.tiles.mapbox.com/v4/directions/#{profile}/#{waypoints}.json" }
    before do
      allow_any_instance_of(Faraday::Connection).to receive(:get).with(url, params_hash) { response }
    end

    context "when it returns 200 as status code" do
      let(:response) { double(status: 200, body: "{}") }
      let(:parsed_response) { double(:parsed_response) }
      before do
        allow(MapboxDirections::ResponseParser).to receive(:directions) { parsed_response }
      end

      it "returns the parsed response" do
        expect(directions).to eq(parsed_response)
      end
    end

    context "when it returns 401 as status code" do
      let(:response) { double(status: 401, body: "{}") }

      it "raises a InvalidAccessTokenError" do
        expect{ directions }.to raise_error(MapboxDirections::InvalidAccessTokenError)
      end
    end

    context "when it returns something else than 200 and 401 as status code" do
      let(:response) { double(status: 404, body: "{ \"message\": \"Not Found\" }") }

      it "returns a response with the message set" do
        expect(directions).to be_kind_of(MapboxDirections::Response)
        expect(directions.error).to eq("Not Found")
      end
    end
  end
end
