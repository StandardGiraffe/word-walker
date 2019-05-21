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
      @word.split("").each_with_index.map do |letter, index|
        {
          letter: letter,
          word: @word,
          index: index,
          id: @id
        }
      end
    end
  end
end
