RSpec.describe MapboxDirections::Parametizer do
  let(:options) do
    {
      access_token: "myAccessToken",
      mode:         mode,
      origin:       origin,
      destination:  "-77.03,38.91",
      geometry:     geometry,
      alternatives: false,
      instructions: instructions,
      invented_opt: "random"
    }
  end
  let(:mode)         { "driving" }
  let(:origin)       { "-122.42,37.78" }
  let(:geometry)     { "polyline" }
  let(:instructions) { "text" }
  let(:client)       { described_class.new(options) }

  describe "params" do
    context "when the access_token wasn't passed" do
      it "raises MissingAccessTokenError" do
        options.delete(:access_token)
        expect { client.params_hash }.to raise_error(MapboxDirections::MissingAccessTokenError)
      end
    end

    context "when the access_token was passed" do
      context "returns only accepted params with allowed values" do
        it "access_token" do
          expect(client.params_hash[:access_token]).to eq("myAccessToken")
        end

        it "geometry" do
          expect(client.params_hash[:geometry]).to eq(geometry)
        end

        it "alternatives" do
          expect(client.params_hash[:alternatives]).to eq(false)
        end

        it "instructions" do
          expect(client.params_hash[:instructions]).to eq(instructions)
        end
      end

      it "doesn't return unallowed values" do
        expect(client.params_hash).to_not include(:invented_opt)
      end

      context "when values are not allowed in an allowed key param" do
        let(:geometry) { "cardinal" }

        it "it's not returned" do
          expect(client.params_hash).to_not include(:geometry)
        end
      end
    end
  end

  describe "profile" do
    context "when the mode of transport is not supported" do
      let(:mode) { "horse" }

      it "raises a UnsupportedTransportModeError error" do
        expect{ client.profile }.to raise_error(MapboxDirections::UnsupportedTransportModeError)
      end
    end

    context "when the mode of transport is supported" do
      it "returns the right string" do
        expect(client.profile).to eq("mapbox.driving")
      end
    end
  end

  describe "waypoints" do
    context "when some of the locations is wrong formated" do
      let(:origin) { "12.234" }

      it "raises a CoordinatesFormatError error" do
        expect{ client.waypoints }.to raise_error(MapboxDirections::CoordinatesFormatError)
      end
    end

    context "when the locations have the right format" do
      it "returns the waympoints as string as origin and destination" do
        expect(client.waypoints).to eq("-122.42,37.78;-77.03,38.91")
      end
    end
  end
end
