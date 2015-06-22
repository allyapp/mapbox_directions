require_relative "./route"

module MapboxDirections
  class Response
    attr_reader :origin, :destination, :waypoints, :routes, :error

    def initialize(attrs)
      @origin      = attrs[:origin]
      @destination = attrs[:destination]
      @waypoints   = attrs[:waypoints] || []
      @routes      = attrs[:routes] || []
      @error       = attrs[:error]
    end
  end
end
