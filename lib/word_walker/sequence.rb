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
          puts "Score: #{grid.score}\n\n"
        end

        puts "\n##### WORST QUALIFYING GRID #####\n\n"
        loser = grids.min_by do |grid|
          grid.score
        end
        loser.print_field
        puts "Score: #{loser.score}\n\n"
        puts "\n##### STATISTICS #####\n\n"
        puts "Failure Rate: #{@failures.count.to_f / @grids.count.to_f * 100}%"
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
        @grids << grid
      rescue OutOfRoomError
        grid.score = -1
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
  end
end
