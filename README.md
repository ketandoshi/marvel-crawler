# MarvelCrawler

Lightweight interface to communicate with the Marvel Comics API. It supports configurable pagination for all API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'marvel_crawler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install marvel_crawler

## Configuration

You need to register on [Marvel Developer Portal](https://developer.marvel.com/) to get your public key and a private key. It requires to do the request on Marvel API.

```ruby
@crawler = MarvelCrawler.client

@crawler.configure do |config|
  config.api_key = 'YOUR_API_KEY'
  config.private_key = 'YOUR_PRIVATE_KEY'
  config.record_per_page = 2 # Optional. By default its 5. You will get this much records per page.
end
```

OR

```ruby
@crawler = MarvelCrawler.client

@crawler.api_key = 'YOUR_API_KEY'
@crawler.private_key = 'YOUR_PRIVATE_KEY'
@crawler.record_per_page = 2 # Optional. By default its 5. You will get this much records per page.
```

## Usage

Below are the examples of supported resources.
All the methods returns an object of `MarvelCrawler::ApiResponse`

### Characters

- Gets lists of characters. [`GET /v1/public/characters`](http://developer.marvel.com/docs#!/public/getCreatorCollection_get_0)

```ruby
@crawler.get_characters(page_num: 2) # Default page number is 1
@crawler.get_characters(name: 'A.I.M.', page_num: 2)
@crawler.get_characters(nameStartsWith: 'A', orderBy: 'modified')
```

- Fetches a single character by id. [`GET /v1/public/characters/{characterId}`](http://developer.marvel.com/docs#!/public/getCharacterIndividual_get_1)

```ruby
@crawler.get_character(id: 1009144)
```

### Comics

- Gets lists of comics. [`GET /v1/public/comics`](https://developer.marvel.com/docs#!/public/getComicsCollection_get_6)

```ruby
@crawler.get_comics(page_num: 2) # Default page number is 1
@crawler.get_comics(title: 'UNIVERSE X SPECIAL: CAP 1 (2001)')
@crawler.get_comics(format: 'magazine')
```

### Creators

- Gets lists of creators. [`GET /v1/public/creators`](https://developer.marvel.com/docs#!/public/getCreatorCollection_get_12)

```ruby
@crawler.get_creators(page_num: 2) # Default page number is 1
```

### Events

- Gets lists of events. [`GET /v1/public/events`](https://developer.marvel.com/docs#!/public/getEventsCollection_get_18)

```ruby
@crawler.get_events(page_num: 2) # Default page number is 1
```

### Series

- Gets lists of series. [`GET /v1/public/series`](https://developer.marvel.com/docs#!/public/getSeriesCollection_get_25)

```ruby
@crawler.get_series(page_num: 2) # Default page number is 1
```

### Stories

- Gets lists of stories. [`GET /v1/public/stories`](https://developer.marvel.com/docs#!/public/getStoryCollection_get_32)

```ruby
@crawler.get_stories(page_num: 2) # Default page number is 1
```

## Response

All the methods returns an object of `MarvelCrawler::ApiResponse`
The object contains following attributes:

```ruby
response.code       => Http code returned from api
response.status     => Status returned from api
response.results    => Contains all the data for the resource
response.etag       => etag returned from api
response.offset     => offset returned from api
response.limit      => limit returned from api which we have used
response.total      => Total number of result available for this resource
response.count      => Total number of result set returned by this call
response.message    => Success OR Error message
```

## Test cases

Execute `rspec .` from project directory to run the rspec tests.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ketandoshi/marvel_crawler. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MarvelCrawler project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ketandoshi/marvel_crawler/blob/master/CODE_OF_CONDUCT.md).
