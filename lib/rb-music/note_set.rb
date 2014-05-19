module RBMusic

  class NoteSet
    include Enumerable

    attr_accessor :notes

    def initialize(notes = [])
      @notes = notes
    end

    def self.from_scale(scale, octave=0, octaves=1)
      raise ArgumentError unless scale.is_a?(Scale) && octaves > 0

      root_note = Note.from_latin("#{scale.key}#{octave}")
      notes = []
      octaves.times do |i|
        notes += scale.degrees.map do |interval_name|
          note = root_note.add(interval_name)
          i.times do |octave_offset|
            note = note.add(:octave)
          end
          note
        end
      end

      self.new(notes)
    end

    def each(&block)
      @notes.each(&block)
    end

    def [](index)
      @notes[index]
    end

    def <<(other)
      @notes << other
    end
    alias_method :push, :<<

    def map(&block)
      @notes.map(&block)
    end

    def ==(other)
      @notes == other.notes
    end
    alias_method :eql?, :==

    def size
      @notes.size
    end

    def add(that)
      NoteSet.new(@notes.map { |note| note.add(that) })
    end

    def subtract(that)
      NoteSet.new(@notes.map { |note| note.subtract(that) })
    end

  end

end
