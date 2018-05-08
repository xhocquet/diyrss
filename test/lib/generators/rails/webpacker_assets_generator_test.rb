require 'test_helper'
require 'generators/rails/webpacker_assets/webpacker_assets_generator'

class Rails::WebpackerAssetsGeneratorTest < Rails::Generators::TestCase
  tests Rails::WebpackerAssetsGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
