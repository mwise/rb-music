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

    def add(that)
      NoteSet.new(@notes.map { |note| note.add(that) })
    end

    def subtract(that)
      NoteSet.new(@notes.map { |note| note.subtract(that) })
    end

  end

end
