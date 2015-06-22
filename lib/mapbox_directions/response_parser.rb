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
        message:     @body["message"]
      )
    end

    private

    def origin
      location(@body["origin"]) if @body["origin"]
    end

    def destination
      location(@body["destination"]) if @body["destination"]
    end

    def location(location)
      coordinates = location["geometry"]["coordinates"]
      Location.new(
        lat:  coordinates.last,
        lng:  coordinates.first,
        name: location["properties"]["name"]
      )
    end

    def routes
      return [] unless @body["routes"] && @body["routes"].any?
      @body["routes"].map do |route|
        Route.new(
          distance: route["distance"],
          duration: route["duration"],
          summary:  route["summary"],
          geometry: route["geometry"],
          steps:    route["steps"]
        )
      end
    end
  end
end
