
module WordWalker
  class OutOfRoomError < StandardError
    attr_reader :field

    def initialize(field)
      @field = field
    end
  end

  def self.read(passage)
    Project.new(passage)
  end

  def self.build!(passage, passes: 10)
    project = Project.new(passage)
    project.build_grids(passes)

    project
  end
end

require_relative "./word_walker/file_helper"
require_relative "./word_walker/report"

require_relative "./word_walker/version"
require_relative "./word_walker/project"
require_relative "./word_walker/sequence"
require_relative "./word_walker/word"
require_relative "./word_walker/grid"
require_relative "./word_walker/point"
