module RBMusic

  class Note
    attr_accessor :coord

    def initialize(coord)
      self.coord = coord
    end

    def self.from_latin(name)
      n = name.split(/(\d+)/)

      if (n.size > 3)
        notes = []
        j = 0
        cycles = (n.size - 1) / 2
        cycles.times do |i|
          coordinate = NOTES[n[j]]
          coordinate = [coordinate[0] + n[j + 1].to_i, coordinate[1]]

          coordinate[0] -= BASE_OFFSET[0]
          coordinate[1] -= BASE_OFFSET[1]

          notes[i] = Note.new(coordinate)
          j += 2
        end
        return notes
      else
        coordinate = NOTES[n[0]]
        coordinate = [coordinate[0] + n[1].to_i, coordinate[1]]

        coordinate[0] -= BASE_OFFSET[0]
        coordinate[1] -= BASE_OFFSET[1]

        return Note.new(coordinate)
      end
    end

    def frequency
      BASE_FREQ * (2.0 ** ((coord[0] * 1200 + coord[1] * 700) / 1200))
    end

    def accidental
      @accidental ||= ((coord[1] + BASE_OFFSET[1]) / 7.0).round
    end

    def octave
      # calculate octave of base note without accidentals
      coord[0] + BASE_OFFSET[0] + 4 * accidental + ((coord[1] + BASE_OFFSET[1] - 7 * accidental) / 2).floor
    end

    def latin
      noteName = NOTE_NAMES[coord[1] + BASE_OFFSET[1] - accidental * 7 + 3]
      accidentalName = ACCIDENTALS[accidental + 2]
      noteName + accidentalName
    end

    def scale(name)
      notes = [add(:unison)]

      SCALES[name.to_sym].each do |interval_name|
        notes << add(Interval.from_name(interval_name))
      end

      notes << add(:octave)
    end

    def add(that)
      # if input is an array return an array
      if that.is_a?(Array)
        notes = that.map { |thing| add(thing) }
        return NoteSet.new(notes)
      end

      # if input is string/symbol try to parse it as interval
      if that.is_a?(String) || that.is_a?(Symbol)
        that = Interval.from_name(that)
      end

      Note.new([coord[0] + that.coord[0], coord[1] + that.coord[1]])
    end

    def subtract(that)
      if that.is_a?(Array)
        notes = that.map { |thing| subtract(thing) }
        return NoteSet.new(notes)
      end

      # if input is string try to parse it as interval
      if that.is_a?(String) || that.is_a?(Symbol)
        that = Interval.from_name(that)
      end

      coordinate = [coord[0] - that.coord[0], coord[1] - that.coord[1]]

      # if input is another note return the difference as an Interval
      that.is_a?(Note) ? Interval.new(coordinate) : Note.new(coordinate)
    end
  end

end
