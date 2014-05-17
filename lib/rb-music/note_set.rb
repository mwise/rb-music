require 'forwardable'

module RBMusic

  class NoteSet
    include Enumerable
    extend Forwardable
    def_delegators :@notes, :each, :<<, :[], :map

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

    def ==(other)
      @notes == other.notes
    end
    alias_method :eql?, :==

    def add(that)
      NoteSet.new(@notes.map { |note| note.add(that) })
    end

    def subtract(that)
      NoteSet.new(@notes.map { |note| note.subtract(that) })
    end

  end

end
