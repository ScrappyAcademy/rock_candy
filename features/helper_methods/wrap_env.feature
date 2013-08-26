Feature: Wrapping ENV

  All Ruby programs provide access to the constant [`ENV`](http://www.ruby-doc.org/core/ENV.html)
  which is a hash like accessor for environment variables.

  Since this is a global constant changes are program wide. Under most
  conditions this is the desired behavior. However, in testing scenarios
  changing the environment only for a specific test is necessary. Using
  `wrap_env` allows for the environment to be adjusted only for a specified
  block of code.

  Scenario: use `wrap_env` to change the environment in the block
    Given a file named "wrap_env_spec.rb" with:
      """ruby
      require 'rock_candy'

      describe 'wrapping the environment' do
        it 'changes the environment in the block' do
          actual_env = nil

          wrap_env('TEST_VAR' => 'changed') do
            actual_env = ENV['TEST_VAR']
          end

          expect(actual_env).to eq 'changed'
        end
      end
      """
    When I set environment variable "TEST_VAR" to "original"
    And I run `rspec wrap_env_spec.rb`
    Then the example passes

  Scenario: use `wrap_env` to stub the environment in the block
    Given a file named "wrap_env_spec.rb" with:
      """ruby
      describe 'wrapping the environment' do
        it 'stubs the environment in the block' do
          actual_env = nil

          wrap_env('STUB_VAR' => 'changed') do
            actual_env = ENV['STUB_VAR']
          end

          expect(actual_env).to eq 'changed'
        end
      end
      """
    When I run `rspec wrap_env_spec.rb`
    Then the example passes

  Scenario: the existing environment is intact in the block
    Given a file named "wrap_env_spec.rb" with:
      """ruby
      describe 'wrapping the environment' do
        it 'leaves existing environment variables alone' do
          actual_env = nil

          wrap_env('TEST_VAR' => 'changed') do
            actual_env = ENV['MY_VAR']
          end

          expect(actual_env).to eq 'original'
        end
      end
      """
    When I set environment variable "MY_VAR" to "original"
    And I run `rspec wrap_env_spec.rb`
    Then the example passes

  Scenario: the environment is reset after the block
    Given a file named "wrap_env_spec.rb" with:
      """ruby
      describe 'wrapping the environment' do
        it 'resets the environment after the block' do
          wrap_env('TEST_VAR' => 'changed') do
            expect(ENV['TEST_VAR']).to eq 'changed'
          end

          expect(ENV['TEST_VAR']).to eq 'original'
        end
      end
      """
    When I set environment variable "TEST_VAR" to "original"
    And I run `rspec wrap_env_spec.rb`
    Then the example passes

  Scenario: the environment is reset even if the block raises an exception
    Given a file named "wrap_env_spec.rb" with:
      """ruby
      describe 'wrapping the environment' do
        it 'resets the environment after the block even on an exception' do
          wrap_env('TEST_VAR' => 'changed') do
            raise 'Chipped a tooth on the candy!'
          end

          expect(ENV['TEST_VAR']).to eq 'original'
        end
      end
      """
    When I set environment variable "TEST_VAR" to "original"
    And I run `rspec wrap_env_spec.rb`
    Then the example passes

  Scenario: the environment changes propagate to sub-processes
    Given a file named "wrap_env_spec.rb" with:
      """ruby
      describe 'wrapping the environment' do
        it 'propagates down into sub-processes' do
          actual_env = nil

          wrap_env('TEST_VAR' => 'changed') do
            actual_env = `ruby -e 'puts ENV["TEST_VAR"]'`
          end

          expect(actual_env).to eq 'changed'
        end
      end
      """
    When I set environment variable "TEST_VAR" to "original"
    And I run `rspec wrap_env_spec.rb`
    Then the example passes
