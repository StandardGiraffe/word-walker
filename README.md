# WordWalker

WordWalker takes a text passage and creates a field of letters in which the text describes a meandering path, boggle-style.

This was a hobby project to see if I could build a program that could generate such fields from an arbitrary block of text.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'word_walker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install word_walker

## Usage

Currently, the gem is limited to printing diagnostic output for demonstration purposes.  If you'd like to try it, run:

```ruby
WordWalker::Sequence.new("Hello world")
```

Output will display the bounding coordinates of the grid (upper-left and lower-right), followed by the grid itself:

```text
[ 0, -1 ] => [ 3, 2 ]

. . O .
H L W .
L E O L
. . D R
```

### Future development goals

- Score produced fields based on compression
- Run multiple builds on a given passage and present the highest-scoring grid
- Output grid properties to JSON or YAML
- Read from a JSON or YAML file to rebuild the grid

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/StandardGiraffe/word_walker. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

... That said, I'm expecting to work on this thing all by myself for now.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the WordWalker project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/StandardGiraffe/word_walker/blob/master/CODE_OF_CONDUCT.md).
