# WordWalker

WordWalker takes a text passage and creates a field of letters in which the text describes a meandering path, boggle-style.

This was a hobby project to see if I could build a program that could generate such fields from an arbitrary block of text.

## Installation

At the moment, probubbly best to just clone this repository and use the included console.

```bash
$ git clone https://github.com/StandardGiraffe/word-walker.git
```

## Usage

Currently, the gem is limited to printing diagnostic output for demonstration purposes.  If you'd like to try it from the command line, enter the custom terminal:

```bash
$ bin/console
```

... and then run something like the following:

```ruby
passage = "Shall I compare thee to a summer's day? / Thou art more lovely and more temperate: / Rough winds do shake the darling buds of May, / And summer's lease hath all too short a date:"

grids = WordWalker::Sequence.new(passage, passes: 5000)

grids.print_results(2)
```

The diagnostic output will display the top candidates (three by default), the top loser, and the failure rate of the builds (ie., how many builds worked their ways into dead-ends):

```text
##### RESULTS #####


##### TOP 2 GRIDS #####

[ -7, -6 ] => [ 2, 5 ]
D N M E E H A T . .
S M A Y R S L E H .
F U B G N I L R A L
D O H A K E T H D L
S O S U S A O T E T
N D D M M A R E T O
I . . E P O L S H O
W . L R S C I L A S
H L E O D A Y T H O
G Y V M T R A U O R
U A N D M O R E T D
O R E T A R E P M A
Score: 111.66666666666667

[ -9, -5 ] => [ 4, 3 ]
. H A S A E L S R E M U S D
. T E V . L Y A N D M O A N
L H O L E R O M T R A R M Y
L A E S D A Y T H O U E A F
T O R M U E T R C I L T M O
O S D M S H E A O S L R P S
R H D S A O T P M H A A E D
T A K N I W H G U O R E T U
D E T H E D A R L I N G B .
Score: 106.34920634920636


##### WORST QUALIFYING GRID #####

[ -3, -11 ] => [ 11, 5 ]
. . . . . . . . L H A H E S A
. . . . . . . L A T M E S E .
. . . . . . . H T O U M R L .
. . . . . . E S O N D S . . .
. . . . . . . T R Y A F . . .
. . . . . . D A T S O M . . .
. . . . . . . . B U D . . . .
A E R U G H W I N G N . . . .
T R E O M D N A Y D I . . . .
. P R R E M U S L S L . . . .
. M E S M A P A E D R . . . .
. T D S H M R O V O A . . . .
. . A A L O E T O S D . . . .
. . Y L I C T E L H E . . . .
. . T H O U E H E A H . . . .
. . . . A R T M R K T . . . .
. . . . . . . . O E . . . . .
Score: 52.54901960784314


##### STATISTICS #####

Failure Rate: 94.84%

```

### Future development goals

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
