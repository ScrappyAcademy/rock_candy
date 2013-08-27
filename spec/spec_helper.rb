if ENV['COVERALLS']
  require 'coveralls'
  Coveralls.wear!
end

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each{|f| require f}

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end

require 'rspec/expectations/errors'

module RSpec::Expectations
  PreconditionNotMetError = Class.new(RSpec::Expectations::ExpectationNotMetError) do
    def message
      "Precondition Failed: #{super}"
    end
  end
end

def precondition
  yield if block_given?
rescue => e
  raise RSpec::Expectations::PreconditionNotMetError.new(e)
end
