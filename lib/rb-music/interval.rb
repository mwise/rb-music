module RBMusic

  class Interval
    attr_accessor :coord

    def initialize(coord)
      self.coord = coord
    end

    def self.from_name(name)
      Interval.new(MUSIC[:intervals][name.to_sym])
    end

    def self.from_semitones(num)
      Interval.new(MUSIC[:intervals_semitones][num])
    end

    def self.from_tones_semitones(tone_semitone)
      # multiply [tones, semitones] vector with [-1 2;3 -5] to get coordinate from tones and semitones
      Interval.new([tone_semitone[0] * -1 + tone_semitone[1] * 3, tone_semitone[0] * 2 + tone_semitone[1] * -5])
    end

    def tone_semitone
      # multiply coord vector with [5 2;3 1] to get coordinate in tones and semitones
      # [5 2;3 1] is the inverse of [-1 2;3 -5], which is the coordinates of [tone; semitone]
      @tone_semitone ||= [coord[0] * 5 + coord[1] * 3, coord[0] * 2 + coord[1] * 1]
    end

    def semitone
      # number of semitones of interval = tones * 2 + semitones
      tone_semitone[0] * 2 + tone_semitone[1]
    end

    def add(interval)
      if interval.is_a?(String)
        interval = Interval.from_name(interval)
      end
      Interval.new([coord[0] + interval.coord[0], coord[1] + interval.coord[1]])
    end

    def subtract(interval)
      if interval.is_a?(String)
        interval = Interval.from_name(interval)
      end
      Interval.new([coord[0] - interval.coord[0], coord[1] - interval.coord[1]])
    end

  end

end
