RSpec.describe MapboxDirections::Route do
  let(:line_coordinates) do
    [[52.513837, 13.389104], [52.513853000000005, 13.389337], [52.514019000000005, 13.389239], [52.514101000000004, 13.389225]]
  end
  let(:polyline_geometry) { Polylines::Encoder.encode_points(line_coordinates, 1e6) }
  let(:route) { described_class.new(geometry: polyline_geometry) }

  describe "transform_polyline_precision" do
    let(:new_precision)           { 1e5 }
    let(:transformed_polyline)    { route.transform_polyline_precision(new_precision) }
    let(:polyline_encoded_to_1e5) { Polylines::Encoder.encode_points(line_coordinates, 1e5) }

    it "transforms the polyline precision from 1e6 to the one required" do
      expect(transformed_polyline).to eq(polyline_encoded_to_1e5)
    end
  end
end
