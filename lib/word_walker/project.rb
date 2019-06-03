module WordWalker
  class Project
    include WordWalker::Report

    def initialize(passage)
      @sequence = Sequence.new(passage)
      @grids = Array.new
    end

    def build_grids(passes)
      passes.times do |pass|
        print_standby_message(passes, pass)

        grid = Grid.new

        @sequence.words.each do |word|
          word.letters.each do |letter|
            grid.write(letter)
          end
        end

        grid.score = score_grid(grid)
        grid.percent_complete = grid.letter_count.to_f / @sequence.letter_count.to_f * 100
        @grids << grid
      rescue OutOfRoomError
        grid.score = -1
        grid.percent_complete = grid.letter_count.to_f / @sequence.letter_count.to_f * 100
        @grids << grid
      end
    end

    # def print_standby_message (passes, current_pass)
    #   system "clear" or system "cls"

    #   puts "############### BUILD IN PROGRESS ###############\n\n"
    #   puts "Attempting to build your grids.  Please stand by..."
    #   puts "Completed: #{current_pass} / #{passes}\n\n"
    #   puts "#################################################"
    # end

    def score_grid(grid)
      return -1 if grid.score

      @sequence.letter_count.to_f / grid.field.count.to_f * 100
    end
  end
end
