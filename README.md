# flespi-ruby

flespi-ruby is a flespi Remote API Wrapper for ruby language.

## Installation

Use the package manager [bundler](https://bundler.io/) to install flespi-ruby.

```bash
gem install flespi
```
OR
```ruby
gem 'flespi'
```
and execute a `bundle install`

## Usage

```ruby
require 'flespi'

# Initialize flespi instance
debug = true
flespi = Flespi.new("YourTokenHere", deubg)

# Login with API Token
flespi.get('/gw/devices/all')

# Logout
flespi.logout
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)