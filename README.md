# WordWalker

WordWalker takes a text passage and creates a field of letters in which the text describes a meandering path, boggle-style.

![Boggle!](https://www.wikihow.com/images/thumb/b/b4/Play-Boggle-Step-19.jpg/aid930445-v4-728px-Play-Boggle-Step-19.jpg)

## Installation

At the moment, it's probably best to just clone this repository and use the included console to fool around:

```bash
$ git clone https://github.com/StandardGiraffe/word-walker.git
```

## Usage

### Initialization

Currently, the gem is limited to printing diagnostic output for demonstration purposes.  If you'd like to try it from the command line, enter the custom terminal:

```bash
$ bin/console
```

... and then run something like the following:

```ruby
passage = <<-PASSAGE
Shall I compare thee to a summer's day?
Thou art more lovely and more temperate:
Rough winds do shake the darling buds of May,
And summer's lease hath all too short a date:
PASSAGE

# Initialize a project and immediately build the grids:
project = WordWalker.build!(passage, passes: 1000)

# Alternatively, initialize the projects and build the grids later:
project = WordWalker.read(passage)
project.build_grids(1000)
```

### Reporting Results

```ruby
# When ready, print the report (specify the number of top candidates to display, default 3):
passage.results(2)
```

This will display the top candidates, the top loser, the failure rate of the builds (ie., how many builds worked their ways into dead-ends), and the average completion rate of the failures before they halted:

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
Score: 111.67

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
Score: 106.36


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
Score: 52.14


##### STATISTICS #####

Failure Rate: 94.84%
Average completion rate of failed grids: 32.67%
```

### Exporing Grids

Completed grids can be exported to JSON files for re-importing later (to be implemented).

```ruby
project.export  #=> ./output/word_walker_output.json

project.export(file_name: "my_grid.json") #=> ./output/my_grid.json

# #export can also take a grid argument, which can be :best, :worst, or a specific Grid instance.
project.export(grid: :best, file_name: "my_best_grid.json")
project.export(grid: :worst, file_name: "yucky.json")

this_grid = project.grids[57]
project.export(grid: this_grid, file_name: "just_right.json")
```

## Future development goals

- Accept strings or text files for the seed passage
- Read from a JSON file to rebuild the grid
- Accept branch points in the provided passage for multiple story paths
- Accept different pathfinding and scoring modules to prioritize different build shapes and strategies
- Save to PDF for classroom printing?
