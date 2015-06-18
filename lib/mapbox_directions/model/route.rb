require_relative "./location"

module MapboxDirections
  class Route
    attr_reader :distance, :duration, :summary, :geometry

    def initialize(attrs)
      @distance = attrs[:distance]
      @duration = attrs[:duration]
      @summary  = attrs[:summary]
      @geometry = attrs[:geometry]
    end
  end
end
