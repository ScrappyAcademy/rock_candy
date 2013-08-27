require "rock_candy/version"
require "rock_candy/helpers"

module RockCandy
end

if defined? RSpec
  RSpec.configure do |c|
    c.include RockCandy::Helpers
  end
end
