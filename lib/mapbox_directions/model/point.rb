require_relative "./point"

module MapboxDirections
  class Point
    attr_reader :lat, :lng

    def initialize(lat, lng)
      @lat = lat
      @lng = lng
    end
  end
end
