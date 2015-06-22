require_relative "./location"

module MapboxDirections
  class Route
    attr_reader :distance, :duration, :summary, :geometry, :steps

    def initialize(attrs)
      @distance = attrs[:distance]
      @duration = attrs[:duration]
      @summary  = attrs[:summary]
      @geometry = attrs[:geometry]
      @geometry = attrs[:geometry]
      @steps    = attrs[:steps]
    end
  end
end
