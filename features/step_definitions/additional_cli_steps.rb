Given /^a spec file named "([^"]*)" with:$/ do |file_name, string|
  steps %Q{
    Given a file named "#{file_name}" with:
    """ruby
    require 'rock_candy'

    #{string}
    """
  }
end

When /^I set environment variable "(.*?)" to "(.*?)"$/ do |variable, value|
  set_env(variable, value)
end

Then /^the examples?(?: all)? pass(?:es)?$/ do
  step %q{the output should contain "0 failures"}
  step %q{the output should not contain "0 examples"}
  step %q{the exit status should be 0}
end
