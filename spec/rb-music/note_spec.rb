require_relative '../spec_helper'

describe RBMusic::Note do

  describe "instance methods" do
    let(:subject) { Note.from_latin("A4") }

    it "has a frequency" do
      subject.frequency.should == 440
    end

    it "has a latin name" do
      subject.latin.should == "A"
    end

    it "has an octave" do
      subject.octave.should == 4
    end

    describe "#add" do
      context "when given a string" do
        it "adds an interval from the string" do
          b4 = Note.from_latin("B4")
          result = subject.add("major_second")

          result.frequency.should == b4.frequency
          result.latin.should == b4.latin
          result.octave.should == b4.octave
        end
      end

      context "when given a symbol" do
        it "adds an interval from the symbol" do
          c5 = Note.from_latin("C5")
          result = subject.add(:minor_third)

          result.frequency.should == c5.frequency
          result.latin.should == c5.latin
          result.octave.should == c5.octave
        end
      end

      context "when given an array" do
        it "returns an NoteSet" do
          b4 = Note.from_latin("B4")
          c5 = Note.from_latin("C5")
          result = subject.add(["major_second", :minor_third])

          result.should be_a(NoteSet)

          result[0].frequency.should == b4.frequency
          result[0].latin.should == b4.latin
          result[0].octave.should == b4.octave

          result[1].frequency.should == c5.frequency
          result[1].latin.should == c5.latin
          result[1].octave.should == c5.octave
        end
      end
    end

    describe "#subtract" do

      context "when given a string" do
        it "returns a note with an interval from the string subtracted" do
          g4 = Note.from_latin("G4")
          result = subject.subtract("major_second")

          result.frequency.should == g4.frequency
          result.latin.should == g4.latin
          result.octave.should == g4.octave
        end
      end

      context "when given a symbol" do
        it "returns a note with an interval from the symbol subtracted" do
          f4 = Note.from_latin("F4")
          result = subject.subtract(:major_third)

          result.frequency.should == f4.frequency
          result.latin.should == f4.latin
          result.octave.should == f4.octave
        end
      end

      context "when given an array" do
        it "returns a NoteSet" do
          f4 = Note.from_latin("F4")
          g4 = Note.from_latin("G4")
          result = subject.subtract(["major_third", :major_second])

          result.should be_a(NoteSet)
          result[0].frequency.should == f4.frequency
          result[0].latin.should == f4.latin
          result[0].octave.should == f4.octave

          result[1].frequency.should == g4.frequency
          result[1].latin.should == g4.latin
          result[1].octave.should == g4.octave
        end
      end

      context "when given a Note" do
        it "returns the difference as an Interval" do
          f4 = Note.from_latin("F4")
          result = subject.subtract(f4)

          result.coord.should == Interval.from_name("major_third").coord
        end
      end
    end

  end

  describe "chords" do
    let(:subject) { Note.from_latin("C4E4G4") }

    it "is an array" do
      subject.should be_a(Array)
      subject[0].latin.should == "C"
    end
  end

  describe "scales" do
    let(:subject) {  }

    it "calculates a C major scale" do
      scale = Note.from_latin("C4").scale("major")
      scale.should be_a(Array)
      scale[0].latin.should == "C"
    end

    it "calculates a enharmonic scales correctly" do
      scale = Note.from_latin("Bb4").scale("major")
      scale.map(&:latin).should == ["Bb", "C", "D", "Eb", "F", "G", "A", "Bb"]

      scale = Note.from_latin("A#4").scale("major")
      scale.map(&:latin).should == ["A#", "B#", "Cx", "D#", "E#", "Fx", "Gx", "A#"]
    end
  end

end
