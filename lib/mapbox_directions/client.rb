require "faraday"
require_relative "./parametizer"
require_relative "./model"

module MapboxDirections
  class Client
    BASE_URL = "http://api.tiles.mapbox.com"
    PATH     = "/v4/directions"

    def initialize(options)
      @options = options
    end

    def directions
      Faraday.get(directions_url, parametizer.params_hash)
    end

    private

    def directions_url
      "#{BASE_URL}#{PATH}/#{parametizer.profile}/#{parametizer.waypoints}.json"
    end

    def parametizer
      @parametizer ||= Parametizer.new(@options)
    end
  end
end
