module WordWalker
  class Grid
    ADJACENTS = [
      [0, 1],
      [1, 1],
      [1, 0],
      [1, -1],
      [0, -1],
      [-1, -1],
      [-1, 0],
      [-1, 1]
    ]

    attr_accessor :score
    attr_accessor :percent_complete
    attr_reader :field
    attr_reader :letter_count
    attr_reader :sequence

    def initialize(sequence:, x_min: 0, y_min: 0, x_max: 1, y_max: 1)
      @sequence = sequence

      @x_min = x_min.to_int
      @y_min = y_min.to_int
      @x_max = x_max.to_int
      @y_max = y_max.to_int

      @stylus = [ @x_min, @y_min ]
      @letter_count = 0

      @score = nil

      populate_field
    end

    def write(letter)
      target_coords = best_adjacent_point(letter)
      expand_field(target_coords[0], target_coords[1])

      @field[target_coords].set_value(letter)
      @letter_count += 1
      @stylus = target_coords
    end

    def print_field
      puts "[ #{@x_min}, #{@y_min} ] => [ #{@x_max}, #{@y_max} ]"
      (@y_min..@y_max).each do |y|
        (@x_min..@x_max).each do |x|
          print @field[[ x, y ]].value + " "
        end
        puts "\n"
      end
    end

    def to_h
      {
        passage: @sequence.passage,
        field: @field.map { |k, v| v.to_h }
      }
    end
  protected
    def populate_field
      @field ||= Hash.new

      (@y_min..@y_max).each do |y|
        (@x_min..@x_max).each do |x|
          @field[[ x, y ]] ||= Point.new(x: x, y: y)
        end
      end
    end

    def expand_field(x, y)
      case
      when (x < @x_min)
        @x_min = x
      when (x > @x_max)
        @x_max = x
      end

      case
      when (y < @y_min)
        @y_min = y
      when (y > @y_max)
        @y_max = y
      end

      populate_field
    end

    def best_adjacent_point(letter)
      return [ @x_min, @y_min ] if @letter_count == 0

      candidates = adjacent_points.shuffle.map do |coords|
        {
          score: evaluate(letter, coords),
          coords: coords
        }
      end.reject do |candidate|
        candidate[:score] == 0
      end

      if candidates.count == 0
        raise WordWalker::OutOfRoomError.new(@field)
      end

      if candidates.reject { |c| c[:score] == 1 }.count == 0
        candidates.sample[:coords]
      else
        candidates.reject { |c| c[:score] == 1 }.sample[:coords]
      end
    end

    def evaluate(letter, coords)
      case
      when @field[coords].nil?
        1
      when !@field[coords].valid?(letter)
        0
      when ((@field[coords].ids.last == letter[:id] - 1) && (letter[:index] == 0))
        0
      else
        2
      end
    end

    def adjacent_points
      ADJACENTS.map do |modifier|
        [ @stylus[0] + modifier[0], @stylus[1] + modifier[1] ]
      end
    end
  end
end
