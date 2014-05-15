module RBMusic

  class Scale
    attr_reader :key
    attr_reader :degrees

    def initialize(key, name)
      scale_name = name.to_sym
      raise ArgumentError unless NOTES.has_key?(key)
      raise ArgumentError unless SCALES.has_key?(scale_name)
      @key = key
      @degrees = [:unison] + SCALES[scale_name]
    end

    def degree_count
      @degree_count ||= @degrees.size
    end

    def notes_in_range(start_note, end_note)
      raise ArgumentError unless start_note.is_a?(Note) && end_note.is_a?(Note)

      NoteSet.new()
    end
  end

end
