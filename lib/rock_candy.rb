require "rock_candy/version"

p 'HERE!!!!'

require 'pry'

module RockCandy
  def wrap_env(*)
  end
end

RSpec.configure do |config|
  binding.pry
  config.include RockCandy
end
