RSpec.describe "directions" do
  let(:options) do
    {
      access_token: "whatever",
      mode:         "driving",
      origin:       "-122.42,37.78",
      destination:  "-77.03,38.91",
      geometry:     geometry,
      alternatives: false,
      instructions: "text"
    }
  end

  let(:directions_response) do
    VCR.use_cassette(cassette) { MapboxDirections.directions(options) }
  end

  describe "success response when" do
    context "polyline as geometry" do
      let(:cassette) { "driving_polyline_as_geometry" }
      let(:geometry) { "polyline" }

      describe "origin" do
        let(:origin) { directions_response.origin }

        it "lat" do
          expect(origin.lat).to eq(37.780094)
        end

        it "lng" do
          expect(origin.lng).to eq(-122.420013)
        end

        it "name" do
          expect(origin.name).to eq("McAllister Street")
        end
      end

      describe "destination" do
        let(:destination) { directions_response.destination }

        it "lat" do
          expect(destination.lat).to eq(38.91008)
        end

        it "lng" do
          expect(destination.lng).to eq(-77.030067)
        end

        it "name" do
          expect(destination.name).to eq("Logan Circle Northwest")
        end
      end

      it "waypoints" do
        expect(directions_response.waypoints).to be_empty
      end

      describe "routes" do
        let(:route) { directions_response.routes.first }

        it "distance" do
          expect(route.distance).to eq(4524005)
        end

        it "duration" do
          expect(route.duration).to eq(163463)
        end

        it "summary" do
          expect(route.summary).to eq("I 80 - I 80;I 90")
        end

        it "geometry" do
          expect(route.geometry).to include("_g|`gA`r|nhFs@cKeEir@aAmOc@mG[sFmBoYiGqy@e@_I[kEoFqv@gDog@aFks@wEqq@U}DeB_ZdYa_@l")
        end

        it "steps is an array with maneuvers" do
          expect(route.steps.first).to include("maneuver")
        end
      end
    end

    context "geojson as geometry" do
      let(:cassette) { "driving_geojson_as_geometry" }
      let(:geometry) { "geojson" }

      describe "routes" do
        let(:route) { directions_response.routes.first }

        describe "geometry" do

          it "type is linestring" do
            expect(route.geometry["type"]).to eq("LineString")
          end

          it "returns coordinates of the linestring" do
            expect(route.geometry["coordinates"].count).to be > 0
          end

          it "each coordinates element is gotten with the expected format" do
            expect(route.geometry["coordinates"].first.first).to eq(-122.420017)
            expect(route.geometry["coordinates"].first.last).to eq(37.780096)
          end
        end
      end
    end
  end
end
