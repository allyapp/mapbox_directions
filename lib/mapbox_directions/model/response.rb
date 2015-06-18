require_relative "./route"

module MapboxDirections
  class Response
    attr_reader :origin, :destination, :waypoints, :routes, :errors

    def initialize(attrs)
      @origin      = attrs[:origin]
      @destination = attrs[:destination]
      @waypoints   = attrs[:waypoints] || []
      @routes      = attrs[:routes] || []
      @errors      = attrs[:errors]
    end
  end
end
