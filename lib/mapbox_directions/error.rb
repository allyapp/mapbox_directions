module MapboxDirections
  class MapboxDirectionsError < StandardError; end
  class CoordinatesFormatError < MapboxDirectionsError; end
  class UnsupportedTransportModeError < MapboxDirectionsError; end
  class MissingAccessTokenError < MapboxDirectionsError; end
  class InvalidAccessTokenError < MapboxDirectionsError; end
end
