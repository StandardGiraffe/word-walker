module WordWalker
  class Sequence
    def initialize(passage, passes: 10)
      @words = parse_passage(passage.to_str.upcase)
      @grids = Array.new
      @passes = passes

      build_grids
    end

    def print_results(best_of = 3)
      @failures = @grids.select { |g| g.score == -1 }
      grids = @grids - @failures

      system "clear" or system "cls"
      puts "\n##### RESULTS #####\n\n"

      if grids.count == 0
        puts "No successful grids were built.  Try increasing the number of passes or shortening the passage."
      else
        puts "\n##### TOP #{best_of > 1 ? "#{best_of} GRIDS" : "GRID"} #####\n\n"
        grids.max_by(best_of) do |grid|
          grid.score
        end.each do |grid|
          grid.print_field
          puts "Score: #{grid.score.round(2)}\n\n"
        end

        puts "\n##### WORST QUALIFYING GRID #####\n\n"
        loser = grids.min_by do |grid|
          grid.score
        end
        loser.print_field
        puts "Score: #{loser.score.round(2)}\n\n"
      end

      puts "\n##### STATISTICS #####\n\n"
      puts "Failure Rate: #{(@failures.count.to_f / @grids.count.to_f * 100).round(2)}%"
      puts "Average completion rate of failed grids: #{average_completion_of_failures.round(2)}%"
      if @failures.count == @passes
        puts "The most successful failure reached #{best_failure.percent_complete.round(2)}% completion."
      end
    end
  protected
    def build_grids
      @passes.times do
        grid = Grid.new

        @words.each do |word|
          word.letters.each do |letter|
            grid.write(letter)
          end
        end

        grid.score = score_grid(grid)
        grid.percent_complete = grid.letter_count.to_f / @letter_count.to_f * 100
        @grids << grid
      rescue OutOfRoomError
        grid.score = -1
        grid.percent_complete = grid.letter_count.to_f / @letter_count.to_f * 100
        @grids << grid
      end
    end

    def parse_passage(passage)
      @letter_count = passage.gsub(/\d|\W/, "").length
      id = 0

      passage.split.map do |word|
        id += 1

        Word.new(word.gsub(/\d|\W/, ""), id)
      end
    end

    def score_grid(grid)
      return -1 if grid.score

      @letter_count.to_f / grid.field.count.to_f * 100
    end

    def average_completion_of_failures
      @failures.map do |failure|
        failure.percent_complete
      end.reduce(:+).to_f / @failures.size
    end

    def best_failure
      @failures.max_by { |f| f.percent_complete }
    end
  end
end
