require 'spec_helper'

def wrap_env(vars)

end

describe 'Testing' do
  it do
    actual_env = nil
    expect{
      wrap_env('FOOBAR' => 'changed') do
        actual_env = ENV['FOOBAR']
      end
    }.to change{ actual_env }.to 'changed'
  end
end
