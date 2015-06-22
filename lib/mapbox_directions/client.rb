require "faraday"
require_relative "./parametizer"
require_relative "./model"
require_relative "./response_parser"

module MapboxDirections
  class Client
    BASE_URL = "http://api.tiles.mapbox.com"
    PATH     = "/v4/directions"

    def initialize(options)
      @options = options
    end

    def directions
      response = Faraday.get(directions_url, parametizer.params_hash)
      parse_response(response)
    end

    private

    def parse_response(response)
      body = JSON.parse(response.body)

      case response.status
      when 200
        ResponseParser.directions(body)
      when 401
        raise InvalidAccessTokenError
      else
        Response.new(error: body["message"])
      end
    end

    def directions_url
      "#{BASE_URL}#{PATH}/#{parametizer.profile}/#{parametizer.waypoints}.json"
    end

    def parametizer
      @parametizer ||= Parametizer.new(@options)
    end
  end
end
