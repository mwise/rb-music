require_relative '../spec_helper'

describe RBMusic::Interval do

  context "after initialization" do
    let(:subject) { described_class.new("some coord") }

    it "assigns the coord argument" do
      subject.coord.should == "some coord"
    end
  end

  describe "class methods" do
    describe "#from_name" do
      it "looks up the correct coordinates" do
        subject = described_class.from_name("major_second")

        subject.coord.should == described_class::INTERVALS[:major_second]
      end
    end

    describe "#from_semitones" do
      it "looks up the correct coordinates" do
        subject = described_class.from_semitones(3)

        subject.coord.should == described_class::INTERVALS_SEMITONES[3]
      end
    end

    describe "#from_tones_semitones" do
      it "looks up the correct coordinates" do
        subject = described_class.from_tones_semitones([0, 3])

        subject.coord.should == [9, -15]
      end
    end
  end

  describe "instance methods" do
    let(:subject) { described_class.from_name("major_second") }

    describe "#tone_semitone" do
      it "returns the tone / semitone vector" do
        subject.tone_semitone.should == [1, 0]
      end
    end

    describe "#semitone" do
      it "returns number of semitones" do
        subject.semitone.should == 2
      end
    end

    describe "#add" do
      context "when given a string" do
        it "adds the string as an Interval" do
          result = subject.add("major_second")
          result.coord.should == Interval.from_name("major_third").coord
        end
      end

      context "when given an Interval" do
        it "adds the given Interval's coordinates and returns a new Interval" do
          result = subject.add(described_class.from_name("minor_second"))
          result.coord.should == Interval.from_name("minor_third").coord
        end
      end
    end

    describe "#subtract" do
      context "when given a string" do
        it "returns a Interval with the given string as Interval subtracted" do
          result = subject.subtract("major_second")
          result.coord.should == Interval.from_name("unison").coord
        end
      end

      context "when given an Interval" do
        it "subtracts the coordinates of the given Interval and returns a new Interval" do
          subject = described_class.from_name("major_third")
          result = subject.subtract(described_class.from_name("major_second"))

          result.coord.should == Interval.from_name("major_second").coord
        end
      end
    end

  end

end
