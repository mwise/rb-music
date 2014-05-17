require_relative '../spec_helper'

describe RBMusic::Note do

  describe "class methods" do

    describe "#from_latin" do

      context "when given a single-character valid note name" do
        let(:note_name) { RBMusic::NOTE_NAMES[0] }
        let(:subject) { described_class.from_latin(note_name) }

        it "returns a #{described_class}" do
          subject.should be_a(described_class)
        end

        it "assigns the correct latin name" do
          subject.latin.should == note_name
        end

        it "assigns a default octave of 0" do
          subject.octave.should == 0
        end
      end

      context "when given a single-character valid note name with octave" do
        let(:note_name) { RBMusic::NOTE_NAMES[0] }
        let(:octave) { 2 }
        let(:subject) { described_class.from_latin("#{note_name}#{octave}") }

        it "returns a #{described_class}" do
          subject.should be_a(described_class)
        end

        it "assigns the correct latin name" do
          subject.latin.should == note_name
        end

        it "assigns the correct octave" do
          subject.octave.should == 2
        end
      end

      context "when given a two-character valid note name with octave" do
        let(:note_name) { "C#" }
        let(:octave) { 3 }
        let(:subject) { described_class.from_latin("#{note_name}#{octave}") }

        it "returns a #{described_class}" do
          subject.should be_a(described_class)
        end

        it "assigns the correct latin name" do
          subject.latin.should == note_name
        end

        it "assigns the correct octave" do
          subject.octave.should == 3
        end
      end

      context "when given a single-character invalid note name" do
        let(:note_name) { "Z" }

        it "raises an exception" do
          lambda {
            described_class.from_latin(note_name)
          }.should raise_error(RBMusic::ArgumentError)
        end
      end

      context "when given an invalid note name / octave string" do
        it "raises an exception" do
          lambda {
            described_class.from_latin("C0E3")
          }.should raise_error(RBMusic::ArgumentError)
        end
      end

      context "when given an empty string" do
        it "raises an exception" do
          lambda {
            described_class.from_latin("")
          }.should raise_error(RBMusic::ArgumentError)
        end
      end

      context "when a non-string" do
        it "raises an exception" do
          lambda {
            described_class.from_latin(1)
          }.should raise_error(RBMusic::ArgumentError)
        end
      end

    end

  end

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

    describe "#==" do
      context "when the argument is a note with the same latin name and octave" do
        it "is true" do
          subject.should == Note.from_latin("A4")
        end
      end

      context "when the argument is a note with a different latin name and same octave" do
        it "is false" do
          subject.should_not == Note.from_latin("B4")
        end
      end

      context "when the argument is a note with the same latin name and a different octave" do
        it "is false" do
          subject.should_not == Note.from_latin("A5")
        end
      end

      context "when the argument is not a note" do
        it "is false" do
          subject.should_not == "foo"
        end
      end
    end

    describe "#enharmonic?" do
      context "when the argument is a note with the same latin name and octave" do
        it "is true" do
          subject.should be_enharmonic(Note.from_latin("A4"))
        end
      end

      context "when the argument is a note with same frequency but a different latin name and/or octave" do
        it "is true" do
          Note.from_latin("E4").should be_enharmonic(Note.from_latin("Fb4"))
          Note.from_latin("Fbb4").should be_enharmonic(Note.from_latin("Eb4"))
        end
      end

      context "when the argument is a note with a different latin name and same octave" do
        it "is false" do
          subject.should_not be_enharmonic(Note.from_latin("B4"))
          subject.should_not be_enharmonically_equivalent_to(Note.from_latin("B4"))
        end
      end

      context "when the argument is a note with the same latin name and a different octave" do
        it "is false" do
          subject.should_not be_enharmonic(Note.from_latin("A5"))
        end
      end

      context "when the argument is not a note" do
        it "raises an exception" do
          lambda {
            subject.enharmonic?("foo")
          }.should raise_exception(RBMusic::ArgumentError)
        end
      end
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

  describe "#scale" do
    let(:subject) { Note.from_latin("C4") }
    let(:scale_name) { "major" }
    let(:scale) { Scale.new(subject.latin, scale_name) }

    it "is a note set with the default octave and range" do
      result = subject.scale(scale_name)

      result.should == NoteSet.from_scale(scale, subject.octave, 1)
    end

    it "accepts an octave range" do
      result = subject.scale(scale_name, 2)

      result.should == NoteSet.from_scale(scale, subject.octave, 2)
    end
  end

end
