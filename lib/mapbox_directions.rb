require "mapbox_directions/version"
require "mapbox_directions/parametizer"
require "mapbox_directions/client"

module MapboxDirections
  module_function

  def directions(options)
    Client.new(options).directions
  end
end
