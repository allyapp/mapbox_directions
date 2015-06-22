RSpec.describe MapboxDirections::ResponseParser do
  let(:geometry) { "U}DeB_ZdYa_@lDuEeZka@mQmVw|@_mAe" }
  let(:summary)  { "I80 - I 80;I 90" }
  let(:distance) { 4524005 }
  let(:duration) { 163463 }
  let(:body) do
    {"origin"=> {"type"=> "Feature","geometry"=> {"type"=> "Point","coordinates"=> [-122.420013,37.780094]},"properties"=> {"name"=> "McAllister Street"}},"destination"=> {"type"=>  "Feature","geometry"=> {"type"=> "Point","coordinates"=> [-77.030067,38.91008]},"properties"=> {"name"=> "Logan Circle Northwest"}},"waypoints"=> [],"routes"=> [{"distance"=> distance,"duration"=> duration,"summary"=> summary,"geometry"=> geometry,"steps"=> []}]}
  end
  let(:response) { described_class.directions(body) }

  describe "directions" do
    describe "origin" do
      let(:origin) { response.origin }

      it "lat" do
        expect(origin.lat).to eq(37.780094)
      end

      it "lng" do
        expect(origin.lng).to eq(-122.420013)
      end

      it "name" do
        expect(origin.name).to eq("McAllister Street")
      end
    end

    describe "destination" do
      let(:destination) { response.destination }

      it "lat" do
        expect(destination.lat).to eq(38.91008)
      end

      it "lng" do
        expect(destination.lng).to eq(-77.030067)
      end

      it "name" do
        expect(destination.name).to eq("Logan Circle Northwest")
      end
    end

    it "waypoints" do
      expect(response.waypoints).to eq(body["waypoints"])
    end

    describe "routes" do
      let(:route) { response.routes.first }

      it "distance" do
        expect(route.distance).to eq(distance)
      end

      it "duration" do
        expect(route.duration).to eq(duration)
      end

      it "summary" do
        expect(route.summary).to eq(summary)
      end

      it "geometry" do
        expect(route.geometry).to eq(geometry)
      end
    end

    describe "message" do
      let(:body) { { "message" => "Not found", "routes" => [] } }

      it "is set" do
        expect(response.message).to eq(body["message"])
      end
    end

    describe "error" do
      let(:body) { { "error" => "Cannot find route between points", "routes" => [] } }

      it "is set" do
        expect(response.error).to eq(body["error"])
      end
    end
  end
end
