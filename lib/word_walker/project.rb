module WordWalker
  class Project
    include WordWalker::Report

    def initialize(passage)
      @sequence = Sequence.new(passage)
      @grids = Array.new

      def build_grids(passes)
        puts "Attempting to build your grid.  Please stand by..."

        passes.times do
          grid = Grid.new

          @sequence.words.each do |word|
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

      def score_grid(grid)
        return -1 if grid.score

        @sequence.letter_count.to_f / grid.field.count.to_f * 100
      end
    end
  end
end
