RSpec.describe MapboxDirections::Point do
  let(:geojson) do
    {"type"=>"Feature", "geometry"=>{"type"=>"Point", "coordinates"=>[-122.420013, 37.780094]}, "properties"=>{"name"=>"McAllister Street"}}
  end

  describe "from_geojson" do
    let(:point) { described_class.from_geojson(geojson) }

    it "lat" do
      expect(point.lat).to eq(37.780094)
    end

    it "lng" do
      expect(point.lng).to eq(-122.420013)
    end
  end
end
