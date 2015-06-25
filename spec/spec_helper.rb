require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'bundler/setup'
Bundler.setup

require 'mapbox_directions'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = {
    match_requests_on: [:method, VCR.request_matchers.uri_without_param(:access_token), :body],
    record:            :new_episodes
  }
end
