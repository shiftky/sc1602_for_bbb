# sc1602_for_bbb

[![Gem Version](https://badge.fury.io/rb/sc1602_for_bbb.svg)](https://badge.fury.io/rb/sc1602_for_bbb)

SC1602 character LCD display library for [BeagleBone Black](http://beagleboard.org/BLACK)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sc1602_for_bbb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sc1602_for_bbb

## Example

```
#!/usr/bin/env ruby
require 'sc1602_for_bbb'

ports = {
  RS: :P8_8,
  EN: :P8_10,
  D4: :P8_18,
  D5: :P8_16,
  D6: :P8_14,
  D7: :P8_12
}
lcd = SC1602ForBBB::LCD.new(ports)

lcd.write("hello, world")
lcd.set_cursor(1, 0)
lcd.write(Time.now.to_s)

sleep 1
lcd.clear
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shiftky/sc1602_for_bbb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

