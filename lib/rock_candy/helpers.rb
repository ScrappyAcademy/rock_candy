module RockCandy
  module Helpers
    module_function

    def wrap_env(envs = {})
      original_envs = ENV.select{ |k, _| envs.has_key? k }
      envs.each{ |k, v| ENV[k] = v }

      yield
    ensure
      envs.each{ |k, _| ENV.delete k }
      original_envs.each{ |k, v| ENV[k] = v }
    end
  end
end
