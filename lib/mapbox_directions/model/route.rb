require_relative "./location"
require "polylines"

module MapboxDirections
  class Route
    POLYLINE_PRECISION = 1e6

    attr_reader :distance, :duration, :summary, :geometry, :steps

    def initialize(attrs)
      @distance = attrs[:distance]
      @duration = attrs[:duration]
      @summary  = attrs[:summary]
      @geometry = attrs[:geometry]
      @steps    = attrs[:steps]
    end

    def transform_polyline_precision(precision = 1e5)
      return @geometry unless @geometry.is_a?(String)
      line_coordinates = Polylines::Decoder.decode_polyline(@geometry, POLYLINE_PRECISION)
      Polylines::Encoder.encode_points(line_coordinates, precision)
    end
  end
end
