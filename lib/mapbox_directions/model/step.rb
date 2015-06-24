require_relative "./maneuver"

module MapboxDirections
  class Step
    extend Forwardable
    delegate %i(lat lng) => :@maneuver

    attr_reader :distance, :duration, :way_name, :direction, :heading, :maneuver

    def initialize(attrs)
      @distance  = attrs[:distance]
      @duration  = attrs[:duration]
      @way_name  = attrs[:way_name]
      @direction = attrs[:direction]
      @heading   = attrs[:heading]
      @maneuver  = attrs[:maneuver]
    end
  end
end
