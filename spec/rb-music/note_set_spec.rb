require_relative '../spec_helper'

describe RBMusic::NoteSet do

  describe "instance methods" do

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
