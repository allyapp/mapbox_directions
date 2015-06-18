require_relative "./error"

module MapboxDirections
  class Parametizer
    ACCEPTED_PARAMS = %w(access_token geometry alternatives instructions)
    TRANSPORT_MODES = %w(driving cycling walking)
    ALLOWED_VALUES  = {
      geometry:     %w(polyline geojson false),
      alternatives: [true, false],
      instructions: %w(text html)
    }

    def initialize(options)
      @options = options
    end

    def params_hash
      raise MissingAccessTokenError unless filtered_params[:access_token]
      filtered_params
    end

    def profile
      raise UnsupportedTransportModeError unless TRANSPORT_MODES.include?(@options[:mode])
      "mapbox.#{@options[:mode]}"
    end

    def waypoints
      raise CoordinatesFormatError if invalid_waypoints?
      "#{@options[:origin]};#{@options[:destination]}"
    end

    private

    def filtered_params
      @filtered_params ||= @options.select { |key, value| valid_key_value?(key, value) }
    end

    def invalid_waypoints?
      invalid_coordinates?(@options[:origin]) || invalid_coordinates?(@options[:destination])
    end

    def invalid_coordinates?(coordinates)
      /^(\-?\d*(\.\d+)?),(\-?\d*(\.\d+)?)$/.match(coordinates).nil?
    end

    def valid_key_value?(key, value)
      key == :access_token || ACCEPTED_PARAMS.include?(key.to_s) && ALLOWED_VALUES[key].include?(value)
    end
  end
end
