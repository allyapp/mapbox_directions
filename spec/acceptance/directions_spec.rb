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

        describe "steps" do
          let(:steps) { route.steps }

          it "is an array with step elements" do
            expect(steps.count).to be > 0
            expect(steps.first).to be_kind_of(MapboxDirections::Step)
          end

          describe "each step contains" do
            let(:step) { steps.first }

            it "distance" do
              expect(step.distance).to eq(611)
            end

            it "duration" do
              expect(step.duration).to eq(53)
            end

            it "way_name" do
              expect(step.way_name).to eq("McAllister Street")
            end

            it "direction" do
              expect(step.direction).to eq("E")
            end

            it "heading" do
              expect(step.heading).to eq(80)
            end

            it "lat" do
              expect(step.lat).to eq(37.780096)
            end

            it "lng" do
              expect(step.lng).to eq(-122.420017)
            end

            describe "maneuver" do
              let(:maneuver) { step.maneuver }

              it "type" do
                expect(maneuver.type).to eq("depart")
              end

              it "instruction" do
                expect(maneuver.instruction).to eq("Head east on McAllister Street")
              end
            end
          end
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
