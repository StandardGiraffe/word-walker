require "word_walker/version"
require "word_walker/sequence"
require "word_walker/word"
require "word_walker/grid"
require "word_walker/point"

module WordWalker
  class OutOfRoomError < StandardError
    attr_reader :field

    def initialize(field)
      @field = field
    end
  end
end
