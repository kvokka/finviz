# frozen_string_literal: true

require "vcr"

RSpec.configure do |config|
  # Add VCR to all tests
  config.around(:each) do |example|
    vcr_tag = example.metadata[:vcr]

    if vcr_tag == false
      VCR.turned_off(&example)
    else
      options = vcr_tag.is_a?(Hash) ? vcr_tag : {}
      path = self.class.name.sub("RSpec::ExampleGroups::", "").split("::").map(&:underscore)
      path << example.metadata[:description]
      name = path.map do |str|
        str.underscore.gsub(/\./, "").gsub(%r{[^\w/]+}, "_").gsub(%r{/$}, "")
      end.join("/")

      VCR.use_cassette(name, options, &example)
    end
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end
