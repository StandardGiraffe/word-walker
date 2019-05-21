module WordWalker
  class Point
    attr_reader :x
    attr_reader :y
    attr_reader :value
    attr_reader :last_id

    def initialize(x:, y:, value: ".")
      @x = x
      @y = y
      @value = value.to_str
      @ids = Array.new
      @last_id = nil
    end

    def valid?(letter)
      ([letter[:letter] , "."].include?(@value)) && !(@ids.include?(letter[:id]))
    end

    def set_value(letter)
      return unless valid?(letter)

      @ids << letter[:id]
      @last_id = letter[:id]
      @value = letter[:letter]
    end

    def coords
      [ @x, @y ]
    end
  end
end
