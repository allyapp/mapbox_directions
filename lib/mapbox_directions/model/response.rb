require_relative "./route"

module MapboxDirections
  class Response
    attr_reader :origin, :destination, :waypoints, :routes, :message, :error

    def initialize(attrs)
      @origin      = attrs[:origin]
      @destination = attrs[:destination]
      @waypoints   = attrs[:waypoints] || []
      @routes      = attrs[:routes] || []
      @message     = attrs[:message]
      @error       = attrs[:error]
    end
  end
end
