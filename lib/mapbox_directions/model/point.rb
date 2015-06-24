require_relative "./point"

module MapboxDirections
  class Point
    attr_reader :lat, :lng

    def self.from_geojson(geojson)
      coords = geojson["geometry"]["coordinates"]
      new(coords.last, coords.first)
    end

    def initialize(lat, lng)
      @lat = lat
      @lng = lng
    end
  end
end
