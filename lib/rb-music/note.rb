module RBMusic

  class Note
    attr_accessor :coord

    def initialize(coord)
      self.coord = coord
    end

    def frequency
      MUSIC[:baseFreq] * (2.0 ** ((self.coord[0] * 1200 + self.coord[1] * 700) / 1200))
    end

    def accidental
      ((self.coord[1] + MUSIC[:baseOffset][1]) / 7.0).round
    end

    def octave
      # calculate octave of base note without accidentals
      acc = self.accidental
      self.coord[0] + MUSIC[:baseOffset][0] + 4 * acc + ((self.coord[1] + MUSIC[:baseOffset][1] - 7 * acc) / 2).floor
    end

    def latin
      noteNames = ['F', 'C', 'G', 'D', 'A', 'E', 'B']
      accidentals = ['bb', 'b', '', '#', 'x']
      acc = self.accidental
      noteNames[self.coord[1] + MUSIC[:baseOffset][1] - acc * 7 + 3] + accidentals[acc + 2]
    end

    def self.from_latin(name)
      out = []
      j = 0
      i = nil
      coordinate = nil

      n = name.split(/(\d+)/)

      if (n.size > 3)
        cycles = (n.size - 1) / 2
        cycles.times do |i|
          coordinate = MUSIC[:notes][n[j]]
          coordinate = [coordinate[0] + n[j + 1].to_i, coordinate[1]]

          coordinate[0] -= MUSIC[:baseOffset][0]
          coordinate[1] -= MUSIC[:baseOffset][1]

          out[i] = Note.new(coordinate)
          j += 2
        end
        return out
      else
        coordinate = MUSIC[:notes][n[0]]
        coordinate = [coordinate[0] + n[1].to_i, coordinate[1]]

        coordinate[0] -= MUSIC[:baseOffset][0]
        coordinate[1] -= MUSIC[:baseOffset][1]

        return Note.new(coordinate)
      end
    end

    def scale(name)
      out = []
      i = nil

      scale = MUSIC[:scales][name.to_sym]

      out.push(self.add(:unison))

      scale.size.times do |i|
        out[i + 1] = self.add(Interval.from_name(scale[i]))
      end

      out.push(self.add(:octave))

      return out
    end

    def add(interval)
      out = []
      i = nil

      # if input is string try to parse it as interval
      if interval.is_a?(String)
        interval = Interval.from_name(interval)
      elsif interval.is_a?(Symbol)
        interval = Interval.from_name(interval)
      end

      # if input is an array return an array
      if interval.is_a?(Array)
        interval.size.times do |i|
          out[i] = self.add(interval[i])
        end

        return NoteSet.new(out)
      else
        return Note.new([self.coord[0] + interval.coord[0], self.coord[1] + interval.coord[1]])
      end
    end

    def subtract(interval)
      out = []
      i = nil
      coordinate = nil

      # if input is string try to parse it as interval
      if interval.is_a?(String)
        interval = Interval.from_name(interval)
      elsif interval.is_a?(Symbol)
        interval = Interval.from_name(interval)
      end

      # if input is an array return an array
      if interval.is_a?(Array)
        interval.size.times do |i|
          out[i] = self.subtract(interval[i])
        end

        #add_addsubtract_func(out)

        return NoteSet.new(out)
      else
          coordinate = [self.coord[0] - interval.coord[0], self.coord[1] - interval.coord[1]]
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
