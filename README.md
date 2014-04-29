# Stashboardmanager [![Gem Version](https://badge.fury.io/rb/stashboardmanager.svg)](http://badge.fury.io/rb/stashboardmanager) [![Build Status](https://travis-ci.org/mattrayner/stashboardmanager.svg?branch=master)](https://travis-ci.org/mattrayner/stashboardmanager)

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

Create a new manager, using your app details and the oauth token and secret:
```ruby
manager = Stashboardmanager::Manager.new("https://YOURAPP.appspot.com", <oauth_token>, <oauth_secret>)
```
To get a list of all your services:
```ruby
manager.services
=begin
  [
    {
      "description"=>"Mail Service", 
      "url"=>"https://YOURAPP.appspot.com/api/v1/services/mail-service", 
      "list"=>{
        "url"=>"https://YOURAPP.appspot.com/api/v1/service-lists/application-services", 
        "description"=>"The main services that run the application", 
        "name"=>"Application Services", 
        "id"=>"application-services"
      }, 
      "current-event"=>nil, 
      "id"=>"mail-service", 
      "name"=>"Mail Service"
    }, 
    {
      "description"=>"PDF Cleaner", 
      "url"=>"https://YOURAPP.appspot.com/api/v1/services/pdf-cleaner", 
      "list"=>{
        "url"=>"https://YOURAPP.appspot.com/api/v1/service-lists/helper-services", 
        "description"=>"The little bits that help without being part of the app itself", 
        "name"=>"Helper Services", "id"=>"helper-services"
      }, 
      "current-event"=>nil, 
      "id"=>"pdf-cleaner", 
      "name"=>"PDF Cleaner"
    }, 
    {
      "description"=>"Website service",
      "url"=>"https://YOURAPP.appspot.com/api/v1/services/website", 
      "current-event"=>{
        "status"=>{
          "description"=>"The service is up", 
          "level"=>"NORMAL", 
          "default"=>true, 
          "image"=>"https://YOURAPP.appspot.com/images/icons/iconic/check_alt.png", 
          "url"=>"https://YOURAPP.appspot.com/api/v1/statuses/up", 
          "id"=>"up", 
          "name"=>"Up"
        }, 
        "url"=>"https://YOURAPP.appspot.com/api/v1/services/website/events/ag5zfnBsYW5ocS1zdGF0c3ISCxIFRXZlbnQYgICAgN6QwQsM", 
        "timestamp"=>"Mon, 28 Apr 2014 14:48:16 GMT", 
        "sid"=>"ag5zfnBsYW5ocS1zdGF0c3ISCxIFRXZlbnQYgICAgN6QwQsM", 
        "message"=>"Web server running A-OK", 
        "informational"=>false
      },
      "id"=>"website", 
      "name"=>"Website"
    }
  ]
=end
```

To receive an array of service ids:
```ruby
manager.service_ids
# =>  ["mail-service", "pdf-cleaner", "website"]
```

To receive the status of a particular service:
```ruby
manager.service("website")
=begin
  {
    "description"=>"Website service",
    "url"=>"https://YOURAPP.appspot.com/api/v1/services/website", 
    "current-event"=>{
      "status"=>{
        "description"=>"The service is up", 
        "level"=>"NORMAL", 
        "default"=>true, 
        "image"=>"https://YOURAPP.appspot.com/images/icons/iconic/check_alt.png", 
        "url"=>"https://YOURAPP.appspot.com/api/v1/statuses/up", 
        "id"=>"up", 
        "name"=>"Up"
      }, 
      "url"=>"https://YOURAPP.appspot.com/api/v1/services/website/events/ag5zfnBsYW5ocS1zdGF0c3ISCxIFRXZlbnQYgICAgN6QwQsM", 
      "timestamp"=>"Mon, 28 Apr 2014 14:48:16 GMT", 
      "sid"=>"ag5zfnBsYW5ocS1zdGF0c3ISCxIFRXZlbnQYgICAgN6QwQsM", 
      "message"=>"Web server running A-OK", 
      "informational"=>false
    },
    "id"=>"website", 
    "name"=>"Website"
  }
=end
```

To find out how wether a service should be updated:
```ruby
manager.service_updatable("website", "up")
# => false
```
The above command first gets the details for this service, and checks it's current status. If the current status is not the same as the status you passed then it will return true.

To update a service:
```ruby
manager.service_update("website", "up", "The website it working!")
```
This command will first check if the service is updatable to the status you've chosen, if it is (it is not already the same status) then a new event is fired.

### Example usage
```ruby
#Create a manager for our stashboar instance
manager = Stashboardmanager::Manager.new("https://YOURAPP.appspot.com", <oauth_token>, <oauth_secret>)

#Get a list of all of their IDs
ids = manager.service_ids

#Iterate over each of them, seting the status to "up" in every case
ids.each do |id|
  manager.service_update(id, "up", "Resetting #{id} to up for testing purposes")
end
```

## Additional help

For additional help, take a look at the [stashboard-ruby](https://github.com/mattrayner/stashboard-ruby) gem, stashboardmanager is build on top of it.

## Contributing

1. Fork it ( http://github.com/mattrayner/stashboardmanager/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
