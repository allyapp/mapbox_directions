# MapboxDirections

[![Build Status](https://travis-ci.org/allyapp/mapbox_directions.svg?branch=master)](https://travis-ci.org/allyapp/mapbox_directions)
[![Code Climate](https://codeclimate.com/github/allyapp/mapbox_directions/badges/gpa.svg)](https://codeclimate.com/github/allyapp/mapbox_directions)
[![Test Coverage](https://codeclimate.com/github/allyapp/mapbox_directions/badges/coverage.svg)](https://codeclimate.com/github/allyapp/mapbox_directions/coverage)

Ruby wrapper for the MapBox Directions Service.

Here you can find the documentation of the API interface:
https://www.mapbox.com/developers/api/directions/

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mapbox_directions'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mapbox_directions

## Usage

Here's the list of supported parameters and the possible values. Note that parameters that are not optional are required:

- **access_token**: public token provided by MapBox.
- **mode**: mode of transport applied to process the routing.
Values: ``driving``, ``cycling``or``walking``.
- **origin**: origin decimal coordinates where the route starts.
Format: ``"#{lng},#{lat}"``
- **destination**: destination decimal coordinates where the route ends.
Format: ``"#{lng},#{lat}"``
- **geometry**(optional): format for route geometry.
Values ``geojson``(default), ``polyline``and ``false`` to omit geometry.
- **alternatives**(optional): whether to get more than one route as an alternative or not.
Values: ``true``(default) or ``false`` as a Boolean.
- **instructions**(optional): format for route instructions.
Values: ``text``(default) or ``html``.


```ruby
require "mapbox_directions"

parameters = {
  access_token: "<your_access_token>",
  mode:         "driving",       # %w(driving cycling walking)
  origin:       "-122.42,37.78", # "#{lng},#{lat}"
  destination:  "-77.03,38.91",  # "#{lng},#{lat}"
  geometry:     "polyline",      # %w(polyline geojson false)
  alternatives: false,           # true or false
  instructions: "text",          # %w(text html)
}
MapboxDirections.directions(parameters)
```

### Response object instance

```ruby
MapboxDirections.directions(parameters)
```

Will return a ``MapboxDirections::Response`` that will be composed by:
- **origin**(``MapboxDirections::Location``): Origin location of the route.
- **destination**(``MapboxDirections::Location``): Destination location of the route.
- **waypoints**
- **routes**(``MapboxDirections::Route``): Array of routes returned.
- **message**: Informative message.
- **error**: Informative error message.

``MapboxDirections::Location``:
- **name**
- **lat**
- **lng**

``MapboxDirections::Route``:
- **distance**
- **duration**
- **summary**
- **geometry**
- **steps**(``Array[MapboxDirections::Step]``)
- Methods:
  - **transform_polyline_precision(precision = 1e5)**: When geometry is polyline, polyline representation format are built with precision 6 (``1e6``).
  In order to get the polyline string transformed into another precision use this method passing the desired precision, which by default is 5 ``1e5``.
  To know more about how polyline are built from coordinates:
  https://developers.google.com/maps/documentation/utilities/polylinealgorithm


``MapboxDirections::Step``:
- **distance**
- **duration**
- **way_name**
- **direction**
- **heading**
- **maneuver**(``MapboxDirections::Maneuver``)
- Methods:
  - **lat**: Latitude of the maneuver point.
  - **lng**: Longitude of the maneuver point.

``MapboxDirections::Maneuver``:
  - **type**
  - **location**
  - **instruction**
  - Methods:
    - **lat**: Latitude of the maneuver point.
    - **lng**: Longitude of the maneuver point.


For more information about what the values of these attributes contain, please look at the [documentation](https://www.mapbox.com/developers/api/directions/).

### Exceptions

Exceptions are triggered to give immediate feedback when there's something wrong in the parameters passed that won't allow to get a successful response.

- **``MapboxDirections::MissingAccessTokenError``**: When the access token is not passed in the parameters or its value is ``nil``


- **``MapboxDirections::InvalidAccessTokenError``**: When the access token is passed in the parameters but it's invalid

- **``MapboxDirections::CoordinatesFormatError``**: When the decimal coordinates are passed bad formatted given the requirements.


- **``MapboxDirections::UnsupportedTransportModeError``**: When the mode of transport is different that the ones that the service supports.


If the exception raise is an undesired behaviour in the context where the code is being executed, they can be rescued one by one or all at once follows:
```ruby
require "mapbox_directions"

def directions(parameters)
  MapboxDirections.directions(parameters)
rescue MapboxDirections::Error
  # Handle exception
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mapbox_directions/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
