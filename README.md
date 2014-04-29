# Stashboardmanager [![Gem Version](https://badge.fury.io/rb/stashboardmanager.svg)](http://badge.fury.io/rb/stashboardmanager)

A super-simple manager for stashboard, allowing you to easily update a stashboard instance with events throughout your application.

This gem adds a number of checks to prevent the repeat posting of updated so if you try to update the status to 'up' and the remote status is already 'up' then nothing happens, saving you bandwidth and time.

## Installation

Add this line to your application's Gemfile:
```ruby
    gem 'stashboardmanager'
```

And then execute:
```bash
    $ bundle
```

Or install it yourself as:
```bash
    $ gem install stashboardmanager
```

## Usage

Install

## Contributing

1. Fork it ( http://github.com/mattrayner/stashboardmanager/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
