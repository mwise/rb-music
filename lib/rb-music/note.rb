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
          coordinate = MUSIC[:notes][n[j]]
          coordinate = [coordinate[0] + n[j + 1].to_i, coordinate[1]]

          coordinate[0] -= MUSIC[:baseOffset][0]
          coordinate[1] -= MUSIC[:baseOffset][1]

          notes[i] = Note.new(coordinate)
          j += 2
        end
        return notes
      else
        coordinate = MUSIC[:notes][n[0]]
        coordinate = [coordinate[0] + n[1].to_i, coordinate[1]]

        coordinate[0] -= MUSIC[:baseOffset][0]
        coordinate[1] -= MUSIC[:baseOffset][1]

        return Note.new(coordinate)
      end
    end

    def frequency
      MUSIC[:baseFreq] * (2.0 ** ((coord[0] * 1200 + coord[1] * 700) / 1200))
    end

    def accidental
      ((coord[1] + MUSIC[:baseOffset][1]) / 7.0).round
    end

    def octave
      # calculate octave of base note without accidentals
      acc = accidental
      coord[0] + MUSIC[:baseOffset][0] + 4 * acc + ((coord[1] + MUSIC[:baseOffset][1] - 7 * acc) / 2).floor
    end

    def latin
      noteNames = ['F', 'C', 'G', 'D', 'A', 'E', 'B']
      accidentals = ['bb', 'b', '', '#', 'x']
      acc = accidental
      noteName = noteNames[coord[1] + MUSIC[:baseOffset][1] - acc * 7 + 3]
      accidentalName = accidentals[acc + 2]
      noteName + accidentalName
    end

    def scale(name)
      notes = [add(:unison)]

      MUSIC[:scales][name.to_sym].each do |interval_name|
        notes << add(Interval.from_name(interval_name))
      end

      notes << add(:octave)
    end

    def add(interval)
      # if input is string try to parse it as interval
      if interval.is_a?(String)
        interval = Interval.from_name(interval)
      elsif interval.is_a?(Symbol)
        interval = Interval.from_name(interval)
      end

      # if input is an array return an array
      if interval.is_a?(Array)
        notes = interval.map { |that| add(that) }

        return NoteSet.new(notes)
      else
        return Note.new([coord[0] + interval.coord[0], coord[1] + interval.coord[1]])
      end
    end

    def subtract(interval)
      # if input is string try to parse it as interval
      if interval.is_a?(String)
        interval = Interval.from_name(interval)
      elsif interval.is_a?(Symbol)
        interval = Interval.from_name(interval)
      end

      # if input is an array return an array
      if interval.is_a?(Array)
        notes = interval.map { |that| subtract(that) }

        return NoteSet.new(notes)
      else
          coordinate = [coord[0] - interval.coord[0], coord[1] - interval.coord[1]]
          if interval.is_a?(Note)
            # if input is another note return the difference as interval
            return Interval.new(coordinate)
          else
            return Note.new(coordinate)
          end
      end
    end
  end

end
