require "mapbox_directions/model/response"

module MapboxDirections
  class ResponseParser
    def self.directions(body)
      new(body).directions
    end

    def initialize(body)
      @body = body
    end

    def directions
      Response.new(
        origin:      origin,
        destination: destination,
        waypoints:   @body["waypoints"],
        routes:      routes,
        message:     @body["message"],
        error:       @body["error"]
      )
    end

    private

    def origin
      Location.from_geojson(@body["origin"]) if @body["origin"]
    end

    def destination
      Location.from_geojson(@body["destination"]) if @body["destination"]
    end

    def routes
      return [] unless @body["routes"] && @body["routes"].any?
      @body["routes"].map do |route|
        Route.new(
          distance: route["distance"],
          duration: route["duration"],
          summary:  route["summary"],
          geometry: route["geometry"],
          steps:    steps(route["steps"])
        )
      end
    end

    def steps(steps)
      steps.map do |step|
        Step.new(
          distance:  step["distance"],
          duration:  step["duration"],
          way_name:  step["way_name"],
          direction: step["direction"],
          heading:   step["heading"],
          maneuver:  maneuver(step["maneuver"])
        )
      end
    end

    def maneuver(maneuver)
      coordinates = maneuver["location"]["coordinates"]
      Maneuver.new(
        type:        maneuver["type"],
        location:    Point.new(coordinates.last, coordinates.first),
        instruction: maneuver["instruction"]
      )
    end
  end
end
