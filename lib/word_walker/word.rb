module WordWalker
  class Word
    attr_reader :word
    attr_reader :letters
    attr_reader :id

    def initialize(word, id)
      @word = word
      @id = id

      @letters = parse_letters
    end
  protected
    def parse_letters
      @word.split("").map do |letter|
        {
          letter: letter,
          word: @word,
          id: @id
        }
      end
    end
  end
end
