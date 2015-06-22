require 'forwardable'

module MapboxDirections
  class Location
    extend Forwardable
    delegate %i(lat lng) => :@point

    attr_reader :point, :name

    def initialize(attrs)
      @point = Point.new(attrs[:lat], attrs[:lng])
      @name  = attrs[:name]
    end
  end
end
