
module WordWalker
  class OutOfRoomError < StandardError
    attr_reader :field

    def initialize(field)
      @field = field
    end
  end
end


require_relative "./word_walker/report"

require_relative "./word_walker/version"
require_relative "./word_walker/sequence"
require_relative "./word_walker/word"
require_relative "./word_walker/grid"
require_relative "./word_walker/point"
