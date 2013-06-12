![Rock Candy](http://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/Rock-Candy-Sticks.jpg/320px-Rock-Candy-Sticks.jpg)

# RockCandy

[![Gem Version](https://badge.fury.io/rb/rock_candy.png)](http://badge.fury.io/rb/rock_candy)
[![Build Status](https://secure.travis-ci.org/ScrappyAcademy/rock_candy.png?branch=master)](http://travis-ci.org/ScrappyAcademy/rock_candy)
[![Dependency Status](https://gemnasium.com/ScrappyAcademy/rock_candy.png?travis)](https://gemnasium.com/ScrappyAcademy/rock_candy)
[![Code Climate](https://codeclimate.com/github/ScrappyAcademy/rock_candy.png)](https://codeclimate.com/github/ScrappyAcademy/rock_candy)
[![Coverage Status](https://coveralls.io/repos/ScrappyAcademy/rock_candy/badge.png)](https://coveralls.io/r/ScrappyAcademy/rock_candy)

Providing sugary syntax to help crystalize your test/spec structure.


## Installation

Add this line to your application's Gemfile:

```ruby
group :test do
  gem 'rock_candy'
end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rock_candy

## Usage

### Preconditions

Often in tests there is a set of preconditions you are expecting to hold true.
Generally, when writing a test these preconditions are either manually
configured or simply assumed to hold true. In the latter case, those
assumptions can come back to bite you.

It is possible to simply add a check on the precondition to verify it holds.
However, when you or a co-worker comes back in a few days, it's generally not
clear why that extra check is there. Enter the `precondition`.

#### RSpec

Without a precondition, you may have the following:

```ruby
before do
  # First precondition check
  expect(consultant).to be_denied_access_to office
end

it 'grants access to a user' do
  expect(project).to be_ready     # Another precondition

  project.assign consultant

  expect(consultant).to be_allowed_access_to office
end
```

Without the annotated comments, it may not be clear in the future why those
checks are there. Also, the error spit out if they fail may be a bit confusing
as it would indicate a generic spec failure.

Using a `precondition` you now have:

```ruby
precondition do
  expect(consultant).to be_denied_access_to office
end

it 'grants access to a user' do
  precondition { expect(project).to be_ready }

  project.assign consultant

  expect(consultant).to be_allowed_access_to office
end
```

Now it is explicit why those checks are there. Additional, if they fail, you'll
see a helpful message:

```
Failures:

  1) Project grants access to a user
     Failure/Error: expect(consultant).to be_denied_access_to office
       Precondition Failed: expected: access denied
            got: access granted
     # ./spec/models/project_spec.rb:21:in `block (4 levels) in <top (required)>'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
