require 'forwardable'

module MapboxDirections
  class Location
    attr_reader :point, :name

    def initialize(attrs)
      @point = Point.new(attrs[:lat], attrs[:lng])
      @name  = attrs[:name]
    end

    def lat
      @point.lat
    end

    def lng
      @point.lng
    end
  end
end
