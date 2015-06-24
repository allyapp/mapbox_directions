RSpec.describe MapboxDirections::Location do
  let(:geojson) do
    {"type"=>"Feature", "geometry"=>{"type"=>"Point", "coordinates"=>[-122.420013, 37.780094]}, "properties"=>{"name"=>"McAllister Street"}}
  end

  describe "from_geojson" do
    let(:location) { described_class.from_geojson(geojson) }

    it "lat" do
      expect(location.lat).to eq(37.780094)
    end

    it "lng" do
      expect(location.lng).to eq(-122.420013)
    end

    it "name" do
      expect(location.name).to eq("McAllister Street")
    end
  end
end
