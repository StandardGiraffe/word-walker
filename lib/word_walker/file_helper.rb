module WordWalker
  module FileHelper
    require 'json'

    def export(grid: :best, file_name: "word_walker_export.json")
      grids = sort_grids

      if grid.class == Symbol && grids.count < 1
        puts "There were no valid grids to export."
        return
      end

      content = case grid
      when Symbol
        if grid == :best
          JSON.pretty_generate(grids.first.to_h)
        elsif grid == :worst
          JSON.pretty_generate(grids.last.to_h)
          # return File.open(file, "w") { |f| JSON.pretty_generate(grids.last.to_h) }
        else
          raise "Please specify :best, :worst, or a specific grid instance."
        end
      when Grid
        JSON.pretty_generate(grid.to_h)
        # return File.open(file, "w") { |f| JSON.pretty_generate(grid.to_h) }
      else
        raise "Please specify :best, :worst, or a specific grid instance."
      end

      File.open(File.expand_path(File.dirname(__FILE__)) + "/../../output/" + file_name, "w") { |f| f.write(content) }
    end

    def sort_grids
      @grids.reject do |grid|
        grid.score == -1
      end.sort_by do |grid|
        grid.score
      end.reverse
    end

    extend self
  end
end
