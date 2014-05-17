module RBMusic

  class Scale
    attr_reader :key
    attr_reader :degrees

    def initialize(key, name)
      @scale_name = name.to_sym
      raise ArgumentError unless NOTES.has_key?(key)
      raise ArgumentError unless SCALES.has_key?(@scale_name)
      @key = key
      @degrees = [:unison] + SCALES[@scale_name]
    end

    def degree_count
      @degree_count ||= @degrees.size
    end
    alias_method :size, :degree_count

    def name
      @name ||= "#{key} #{human_scale_name}"
    end

    private
    def human_scale_name
      @scale_name.to_s.split("_").map { |word| word.capitalize }.join(" ")
    end
  end

end
