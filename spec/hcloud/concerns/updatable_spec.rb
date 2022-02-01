# frozen_string_literal: true

RSpec.describe HCloud::Updatable do
  subject(:resource) { ExampleResource.new }

  describe "#update" do
    it "updates the resource" do
      stub_request(:put, "https://api.hetzner.cloud/v1/examples/#{resource.id}")
        .with(body: resource.attributes.slice(*resource.updatable_attributes.map(&:to_s)))
        .to_return(body: { example: resource.attributes.merge(name: "my_name") }.to_json)

      resource.update

      expect(resource.name).to eq "my_name"
    end
  end
end
