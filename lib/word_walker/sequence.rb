module WordWalker
  class Sequence
    include WordWalker::Report

    def initialize(passage, passes: 10)
      @words = parse_passage(passage.to_str.upcase)
      @grids = Array.new
      @passes = passes

      build_grids
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
  end
end
