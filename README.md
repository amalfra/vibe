Vibe API
========
[![Gem Version](https://badge.fury.io/rb/vibe.png)][gem]
[![Dependency Status](https://gemnasium.com/amalfra/vibe.png)][gemnasium]
[![Code Climate](https://codeclimate.com/github/amalfra/vibe.png)][codeclimate]
[![Travis CI](https://travis-ci.org/amalfra/vibe.svg?branch=master)][travis]

[gem]: http://badge.fury.io/rb/vibe
[gemnasium]: https://gemnasium.com/amalfra/vibe
[codeclimate]: https://codeclimate.com/github/amalfra/vibe
[travis]: https://travis-ci.org/amalfra/vibe/

[RDocs](http://rubydoc.info/github/amalfra/vibe/master/frames)

A Ruby wrapper for the Vibe REST API.

> Get API key here : https://z1.vibeapp.co/dev/

## Installation

Install the gem by running

```ruby
gem install vibe
```

or put it in your Gemfile and run `bundle install`

```ruby
gem "vibe"
```

## Usage

Create a new instance

```ruby
vibe = Vibe.new
```

At this stage you can also supply the configuration parameter `:api_key`, `:cache` which is used throughout the API. These can be passed directly as hash options:

```ruby
vibe = Vibe.new api_key: 'api_key'
```

Alternatively, you can configure the Vibe settings by passing a block:

```ruby
vibe = Vibe.new do |config|
  config.api_key   = 'api_key'
  config.cache     = false # Maybe i need to turn off cache
end
```

## Cache

The wrapper has Cache feature which would cache API response for a day. **The stats API call which is used to get the status of an API key won't be cached**. The currently supported Cache methods are:
 * File: Stored in system temporary path.

## API

The currently available api methods are:
 * get_data(email) - Get Data from an Email
 * stats           - Get Stats for API Key. If API key parameter is not
                     passed then the one in config will be used


## Development

Questions, problems or suggestions? Please post them on the [issue tracker](https://github.com/amalfra/vibe/issues). 

You can contribute changes by forking the project and submitting a pull request. You can ensure the tests are passing by running `rake test`. Feel free to contribute :heart_eyes:


UNDER MIT LICENSE
=================

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
