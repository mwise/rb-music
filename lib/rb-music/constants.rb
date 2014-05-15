module RBMusic

  NOTE_NAMES = ["F", "C", "G", "D", "A", "E", "B"]
  ACCIDENTALS = ["bb", "b", "", "#", "x"]

  # notes - two dimensional [octave, fifth] - relative to the 'main' note
  NOTES = {
    "Fb" => [6, -10],
    "Cb" => [5, -9],
    "Gb" => [5, -8],
    "Db" => [4, -7],
    "Ab" => [4, -6],
    "Eb" => [3, -5],
    "Bb" => [3, -4],

    "F" => [2, -3],
    "C" => [1, -2],
    "G" => [1, -1],
    "D" => [0, 0],
    "A" => [0, 1],
    "E" => [-1, 2],
    "B" => [-1, 3],

    "F#" => [-2, 4],
    "C#" => [-3, 5],
    "G#" => [-3, 6],
    "D#" => [-4, 7],
    "A#" => [-4, 8],
    "E#" => [-5, 9],
    "B#" => [-5, 10]
  }

  BASE_FREQ = 440  # A4 'main' note
  BASE_OFFSET = [4, 1]  # offset of base note from D0

  # intervals - two dimensional [octave, fifth] - relative to the 'main' note
  INTERVALS = {
    unison:           [0, 0],
    minor_second:     [3, -5],
    major_second:     [-1, 2],
    minor_third:      [2, -3],
    major_third:      [-2, 4],
    fourth:           [1, -1],
    augmented_fourth: [-3, 6],
    tritone:          [-3, 6],
    diminished_fifth: [4, -6],
    fifth:            [0, 1],
    minor_sixth:      [3, -4],
    major_sixth:      [-1, 3],
    minor_seventh:    [2, -2],
    major_seventh:    [-2, 5],
    octave:           [1, 0]
  }

  INTERVALS_SEMITONES = {
    0 =>  [0, 0],
    1 =>  [3, -5],
    2 =>  [-1, 2],
    3 =>  [2, -3],
    4 =>  [-2, 4],
    5 =>  [1, -1],
    6 =>  [-3, 6],
    7 =>  [0, 1],
    8 =>  [3, -4],
    9 =>  [-1, 3],
    10 => [2, -2],
    11 => [-2, 5],
    12 => [1, 0]
  }

  SCALES = {
    major: [:major_second, :major_third, :fourth, :fifth, :major_sixth, :major_seventh],
    natural_minor: [:major_second, :minor_third, :fourth, :fifth, :minor_sixth, :minor_seventh],
    harmonic_minor: [:major_second, :minor_third, :fourth, :fifth, :minor_sixth, :major_seventh],
    major_pentatonic: [:major_second, :major_third, :fifth, :major_sixth],
    minor_pentatonic: [:minor_third, :fourth, :minor_sixth, 'minor_seventh']
  }

end