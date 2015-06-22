# MapboxDirections

[![Build Status](https://travis-ci.org/allyapp/mapbox_directions.svg?branch=master)](https://travis-ci.org/allyapp/mapbox_directions)
[![Code Climate](https://codeclimate.com/github/allyapp/mapbox_directions/badges/gpa.svg)](https://codeclimate.com/github/allyapp/mapbox_directions)

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

```ruby
require "mapbox_directions"
options = {
  access_token: "<your_access_token>",
  mode:         "driving",       # %w(driving cycling walking)
  origin:       "-122.42,37.78", # lng,lat
  destination:  "-77.03,38.91",  # lng,lat
  geometry:     "polyline",      # %w(polyline geojson false)
  alternatives: false,           # true | false
  instructions: "text",          # %w(text html)
}
MapboxDirections.directions(options)
```

### Exceptions

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mapbox_directions/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
