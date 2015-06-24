require 'forwardable'

module MapboxDirections
  class Location
    extend Forwardable
    delegate %i(lat lng) => :@point

    attr_reader :point, :name

    def self.from_geojson(geojson)
      new(point: Point.from_geojson(geojson), name: geojson["properties"]["name"])
    end

    def initialize(attrs)
      @point = attrs[:point] || Point.new(attrs[:lat], attrs[:lng])
      @name  = attrs[:name]
    end
  end
end
