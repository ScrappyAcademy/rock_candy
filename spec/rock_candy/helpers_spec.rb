require 'spec_helper'
require 'rock_candy/helpers'

describe RockCandy::Helpers do

  context "wrapping the environment variables" do
    it "delegates to the provided block" do
      expect{ |b| RockCandy::Helpers.wrap_env(&b) }.to yield_with_no_args
    end

    it "stubs a non-existing variable" do
      precondition{ expect(ENV).not_to have_key 'STUB_VAR' }

      RockCandy::Helpers.wrap_env('STUB_VAR' => 'set') do
        expect(ENV['STUB_VAR']).to eq 'set'
      end
    end

    it "leaves existing variables set" do
      precondition{ expect(ENV).not_to have_key 'STUB_VAR' }
      ENV['TEST_VAR'] = 'foo'

      RockCandy::Helpers.wrap_env('STUB_VAR' => 'set') do
        expect(ENV['TEST_VAR']).to eq 'foo'
      end
    end

    it "removes stubbed variables after the block" do
      precondition{ expect(ENV).not_to have_key 'STUB_VAR' }

      RockCandy::Helpers.wrap_env('STUB_VAR' => 'bar') { :no_op }

      expect(ENV).not_to have_key 'STUB_VAR'
    end

    it "overwrites an existing variable" do
      ENV['TEST_VAR'] = 'foo'

      RockCandy::Helpers.wrap_env('TEST_VAR' => 'bar') do
        expect(ENV['TEST_VAR']).to eq 'bar'
      end
    end

    it "resets the variable after the block" do
      ENV['TEST_VAR'] = 'foo'

      RockCandy::Helpers.wrap_env('TEST_VAR' => 'bar') { :no_op }

      expect(ENV['TEST_VAR']).to eq 'foo'
    end

    it "restores the environment even if the block raises an exception" do
      precondition{ expect(ENV).not_to have_key 'STUB_VAR' }
      ENV['TEST_VAR'] = 'foo'

      expect{
        RockCandy::Helpers.wrap_env('TEST_VAR' => 'bar') { raise 'Sad Panda' }
      }.to raise_error 'Sad Panda'

      expect(ENV).not_to have_key 'STUB_VAR'
      expect(ENV['TEST_VAR']).to eq 'foo'
    end

    it "changes the environment for sub-processes" do
      precondition{ expect(ENV).not_to have_key 'STUB_VAR' }
      ENV['TEST_VAR'] = 'foo'

      RockCandy::Helpers.wrap_env('STUB_VAR' => 'set', 'TEST_VAR' => 'bar') do
        expect(`ruby -e "print ENV['STUB_VAR'] + ' ' +  ENV['TEST_VAR']"`)
          .to eq 'set bar'
      end
    end
  end

end
