# rb-music

**rb-music** is a Ruby gem for working with musical notes, scales and intervals. It is basically a direct port of the wonderful [music.js](https://github.com/gregjopa/music.js) library by Greg Jopa.

## Installation

In your Gemfile:

```
gem 'rb-music', git: 'https://github.com/mwise/rb-music', branch: 'master'
```

In your Ruby code:

```
require 'rb-music'
```

## Overview

### Note

`Note.from_latin(name)`: Note by latin name and octave

```ruby
n = Note.from_latin('A4');  # single note
n.frequency  # 440
n.latin  # "A"
n.octave # 4 

cmaj = Note.from_latin('C4E4G4')  # chord = array of notes
cmaj[0].frequency  # 261.625...
cmaj[0].latin # "C"
cmaj[0].octave # 4

n = Note.from_latin('C4')  # base note for scale
n.scale('major') # scale = array of notes  
```

### Interval

`Interval.from_name(name)`: Interval by name

`Interval.from_semitones(num)`: Interval by semitones

```ruby
Interval.from_name('fifth') # define by name
whole_step = Interval.from_semitones(2) # define by # of semitones

c = Note.from_latin('C3')

# use intervals to transpose notes
d = c.add(whole_step) 

# use intervals to define chords
cmaj = c.add(['unison','major third','fifth'])
```
