RSpec.describe MapboxDirections::ResponseParser do
  let(:geometry) { "U}DeB_ZdYa_@lDuEeZka@mQmVw|@_mAe" }
  let(:summary)  { "I80 - I 80;I 90" }
  let(:distance) { 4524005 }
  let(:duration) { 163463 }
  let(:body) do
    {"origin"=> {"type"=> "Feature","geometry"=> {"type"=> "Point","coordinates"=> [-122.420013,37.780094]},"properties"=> {"name"=> "McAllister Street"}},"destination"=> {"type"=>  "Feature","geometry"=> {"type"=> "Point","coordinates"=> [-77.030067,38.91008]},"properties"=> {"name"=> "Logan Circle Northwest"}},"waypoints"=> [],"routes"=> [{"distance"=> distance,"duration"=> duration,"summary"=> summary,"geometry"=> geometry,"steps"=> route_steps}]}
  end
  let(:route_steps) do
    [{"maneuver"=>{"type"=>"depart", "location"=>{"type"=>"Point", "coordinates"=>[-122.420017, 37.780096]}, "instruction"=>"Head east on McAllister Street"}, "distance"=>611, "duration"=>53, "way_name"=>"McAllister Street", "direction"=>"E", "heading"=>80}]
  end
  let(:response) { described_class.directions(body) }

  describe "directions" do
    describe "origin" do
      let(:origin) { response.origin }

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
      let(:destination) { response.destination }

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
      expect(response.waypoints).to eq(body["waypoints"])
    end

    describe "routes" do
      let(:route) { response.routes.first }

      it "distance" do
        expect(route.distance).to eq(distance)
      end

      it "duration" do
        expect(route.duration).to eq(duration)
      end

      it "summary" do
        expect(route.summary).to eq(summary)
      end

      it "geometry" do
        expect(route.geometry).to eq(geometry)
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

    describe "message" do
      let(:body) { { "message" => "Not found", "routes" => [] } }

      it "is set" do
        expect(response.message).to eq(body["message"])
      end
    end

    describe "error" do
      let(:body) { { "error" => "Cannot find route between points", "routes" => [] } }

      it "is set" do
        expect(response.error).to eq(body["error"])
      end
    end
  end
end
