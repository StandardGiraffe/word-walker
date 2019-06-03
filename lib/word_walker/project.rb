module WordWalker
  class Project
    include WordWalker::Report
    include WordWalker::FileHelper

    attr_reader :grids

    def initialize(passage)
      @sequence = Sequence.new(passage)
      @grids = Array.new
    end

    def build_grids(passes = 100)
      passes.times do |pass|
        print_standby_message(passes, pass)

        grid = Grid.new(sequence: @sequence)

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
  protected
    def score_grid(grid)
      return -1 if grid.score

      @sequence.letter_count.to_f / grid.field.count.to_f * 100
    end
  end
end
