require_relative '../spec_helper'

describe RBMusic::NoteSet do

  describe "class methods" do
    describe "#from_scale" do
      let(:scale) { RBMusic::Scale.new("C", "major") }

      context "without any arguments" do
        it "raises an ArgumentError"  do
          lambda {
            described_class.from_scale
          }.should raise_error(ArgumentError)
        end
      end

      context "without a valid RBMusic::Scale" do
        it "raises an ArgumentError"  do
          lambda {
            described_class.from_scale("foo")
          }.should raise_error(RBMusic::ArgumentError)
        end
      end

      context "with a RBMusic::Scale only" do
        let(:subject) { described_class.from_scale(scale) }

        it "returns a #{described_class}" do
          subject.should be_a(described_class)
        end

        it "builds a note for each scale degree in the default octave ranage (1)" do
          subject.notes.length.should == scale.degree_count
        end

        it "builds notes from the default octave (0)" do
          subject.notes[0].should == Note.from_latin("#{scale.key}0")
        end
      end

      context "with a RBMusic::Scale and an octave" do
        let(:octave) { 3 }
        let(:subject) { described_class.from_scale(scale, octave) }

        it "builds notes for the scale from the given octave" do
          subject.notes[0].should == Note.from_latin("#{scale.key}#{octave}")
          subject.notes.length.should == scale.degree_count
        end
      end

      context "with a RBMusic::Scale, octave and octave range" do
        let(:octave) { 3 }
        let(:octaves) { 2 }
        let(:subject) { described_class.from_scale(scale, octave, octaves) }

        it "builds notes for the given octave range" do
          degrees = scale.degree_count

          subject.notes[0].should == Note.from_latin("#{scale.key}#{octave}")
          subject.notes[degrees].should == Note.from_latin("#{scale.key}#{octave + 1}")
          subject.notes.length.should == scale.degree_count * octaves
        end
      end

      context "with an invalid octave range" do
        it "raises an ArgumentError" do
          lambda {
            described_class.from_scale(scale, 3, -1)
          }.should raise_exception(RBMusic::ArgumentError)
        end
      end
    end
  end

  describe "instance methods" do

    describe "#initialize" do
      let(:notes_array) { ["foo", "bar"] }

      it "assigns the notes array" do
        subject = described_class.new(notes_array)

        subject.notes.should == notes_array
      end
    end

    describe "#==" do
      let(:notes) { ["foo", "bar"] }

      context "when all the notes are equal" do
        it "is true" do
          described_class.new(notes).should == described_class.new(notes)
        end
      end

      context "when note all the notes are equal" do
        it "is false" do
          described_class.new(notes).should_not == described_class.new([1, 2])
        end
      end
    end

    describe "#size" do
      let(:notes) { ["foo", "bar"] }

      it "is the amount of notes in the set" do
        described_class.new(notes).size.should == 2
      end
    end

    describe "#add" do
      let(:f4) { Note.from_latin("F4") }
      let(:g4) { Note.from_latin("G4") }
      let(:subject) { NoteSet.new([f4, g4]) }

      context "when adding an interval string" do
        let(:operand) { "major_second" }

        it "retuns a new NoteSet with the operand added to each element of the original" do
          result = subject.add(operand)

          result.should be_a(NoteSet)
          result[0].frequency.should == subject[0].add(operand).frequency
          result[1].frequency.should == subject[1].add(operand).frequency
        end
      end

      context "when adding an interval symbol" do
        let(:operand) { :major_second }

        it "retuns a new NoteSet with the operand added to each element of the original" do
          result = subject.add(operand)

          result.should be_a(NoteSet)
          result[0].frequency.should == subject[0].add(operand).frequency
          result[1].frequency.should == subject[1].add(operand).frequency
        end
      end

      context "when adding an note" do
        let(:operand) { Note.from_latin("C4") }

        it "retuns a new NoteSet with the operand added to each element of the original" do
          result = subject.add(operand)

          result.should be_a(NoteSet)
          result[0].frequency.should == subject[0].add(operand).frequency
          result[1].frequency.should == subject[1].add(operand).frequency
        end
      end

    end

    describe "#subtract" do
      let(:f4) { Note.from_latin("F4") }
      let(:g4) { Note.from_latin("G4") }
      let(:subject) { NoteSet.new([f4, g4]) }

      context "when subtracting an interval string" do
        let(:operand) { "major_second" }

        it "retuns a new NoteSet with the operand subtracted to each element of the original" do
          result = subject.subtract(operand)

          result.should be_a(NoteSet)
          result[0].frequency.should == subject[0].subtract(operand).frequency
          result[1].frequency.should == subject[1].subtract(operand).frequency
        end
      end

      context "when subtracting an interval symbol" do
        let(:operand) { :major_second }

        it "retuns a new NoteSet with the operand subtracted to each element of the original" do
          result = subject.subtract(operand)

          result.should be_a(NoteSet)
          result[0].frequency.should == subject[0].subtract(operand).frequency
          result[1].frequency.should == subject[1].subtract(operand).frequency
        end
      end

      context "when subtracting an note" do
        let(:operand) { Note.from_latin("C4") }

        it "retuns a new NoteSet with the operand subtracted to each element of the original" do
          result = subject.subtract(operand)

          result.should be_a(NoteSet)
          result[0].coord.should == subject[0].subtract(operand).coord
          result[1].coord.should == subject[1].subtract(operand).coord
        end
      end

    end

  end

end
