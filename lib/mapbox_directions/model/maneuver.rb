module MapboxDirections
  class Maneuver
    extend Forwardable
    delegate %i(lat lng) => :@location

    attr_reader :type, :location, :instruction

    def initialize(attrs)
      @type        = attrs[:type]
      @location    = attrs[:location]
      @instruction = attrs[:instruction]
    end
  end
end
