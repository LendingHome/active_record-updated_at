if ENV["CODECLIMATE_REPO_TOKEN"]
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
else
  require "simplecov"
  SimpleCov.start { add_filter("/vendor/bundle/") }
end

require File.expand_path("../../lib/active_record-updated_at", __FILE__)
ActiveRecord::Migration.verbose = false

require "combustion"
Combustion.initialize!(:active_record)

require "rspec/rails"
RSpec::Expectations.configuration.on_potential_false_positives = :nothing

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
  config.filter_run :focus
  config.raise_errors_for_deprecations!
  config.run_all_when_everything_filtered = true
  config.use_transactional_fixtures = true
end
