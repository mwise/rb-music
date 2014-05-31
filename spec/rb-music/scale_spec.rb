require_relative '../spec_helper'

describe RBMusic::Scale do

  describe "initializer" do

    context "when called with no arguments" do
      it "raises an ArgumentError"  do
        lambda {
          described_class.new
        }.should raise_error(ArgumentError)
      end
    end

    context "when called without a valid note name as key" do
      it "raises an ArgumentError" do
        lambda {
          described_class.new("foo", "bar")
        }.should raise_error(RBMusic::ArgumentError)
      end
    end

    context "when called without a valid key and scale name" do
      it "raises an ArgumentError" do
        lambda {
          described_class.new("C", "bar")
        }.should raise_error(RBMusic::ArgumentError)
      end
    end

    context "when called with a valid key and scale" do
      let(:key) { "C" }
      let(:name) { "major" }
      let(:subject) { described_class.new(key, name) }

      it "assigns the key attribute" do
        subject.key.should == key
      end

      it "assigns the degrees based on the name" do
        subject.degrees.should == [:unison] + SCALES[name.to_sym]
      end
    end
  end

  describe "instance methods" do
    let(:subject) { described_class.new("C", "major") }

    describe "#degree_count" do
      it "is the number of scale degrees" do
        subject.degree_count.should == subject.degrees.size
      end
    end

    describe "#name" do
      it "is the human-readable name" do
        subject.name.should == "C Major"
        Scale.new("D#", "harmonic_minor").name.should == "D# Harmonic Minor"
      end
    end
  end

  describe "scale types" do
    let(:note) { Note.from_latin("C4") }

    {
      "major" => ["C", "D", "E", "F", "G", "A", "B"],
      "natural_minor" => ["C", "D", "Eb", "F", "G", "Ab", "Bb"],
      "natural_minor" => ["C", "D", "Eb", "F", "G", "Ab", "Bb"],
      "harmonic_minor" => ["C", "D", "Eb", "F", "G", "Ab", "B"],
      "major_pentatonic" => ["C", "D", "E", "G", "A"],
      "minor_pentatonic" => ["C", "Eb", "F", "G", "Bb"],
      "blues" => ["C", "Eb", "F", "F#", "G", "Bb"],
      "ionian" => ["C", "D", "E", "F", "G", "A", "B"],
      "dorian" => ["C", "D", "Eb", "F", "G", "A", "Bb"],
      "phrygian" => ["C", "Db", "Eb", "F", "G", "A", "Bb"],
      "lydian" => ["C", "D", "E", "F#", "G", "A", "B"],
      "mixolydian" => ["C", "D", "E", "F", "G", "A", "Bb"],
      "aeolian" => ["C", "D", "Eb", "F", "G", "Ab", "Bb"],
      "locrian" => ["C", "Db", "Eb", "F", "Gb", "Ab", "Bb"],
      "chromatic" => ["C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab", "A", "Bb", "B"],
    }.each_pair do |key, value|
      it "calculates a #{key} scale" do
        note.scale(key).map(&:latin).should == value
      end
    end
  end

end
