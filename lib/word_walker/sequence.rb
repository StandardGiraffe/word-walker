module WordWalker
  class Sequence
    attr_reader :letter_count
    attr_reader :passage
    attr_reader :words

    def initialize(passage, passes: 10)
      @passage = passage

      @words = parse_passage(@passage.to_str.upcase)
    end
  protected
    def parse_passage(passage)
      @letter_count = passage.gsub(/\d|\W/, "").length
      id = 0

      passage.split.map do |word|
        id += 1

        Word.new(word.gsub(/\d|\W/, ""), id)
      end
    end
  end
end
