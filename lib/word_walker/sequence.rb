module WordWalker
  class Sequence
    def initialize(words, grid: Grid.new)
      @words = parse_words(words.to_str.upcase)
      @grid = grid

      write_out_words
    end
  protected
    def write_out_words
      @words.each do |word|
        word.letters.each do |letter|
          @grid.write(letter)
        end
      end

      @grid.print_field
    end

    def parse_words(words)
      id = 0

      words.split.map do |word|
        id += 1

        Word.new(word.gsub(/\d|\W/, ""), id)
      end
    end
  end
end
