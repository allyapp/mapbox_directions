module MapboxDirections
  class Error < StandardError; end
  class CoordinatesFormatError < Error; end
  class UnsupportedTransportModeError < Error; end
  class MissingAccessTokenError < Error; end
  class InvalidAccessTokenError < Error; end
end
