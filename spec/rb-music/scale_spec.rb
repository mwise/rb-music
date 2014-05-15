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

    describe "#notes_in_range" do

      context "when called with no arguments" do
        it "raises an exception" do
          lambda { subject.notes_in_range }.should raise_exception
        end
      end

      context "when called with an invalid start note" do
        it "raises an exception" do
          lambda {
            subject.notes_in_range("foo", "bar")
          }.should raise_exception(RBMusic::ArgumentError)
        end
      end

      context "when called with an invalid end note" do
        let(:start_note) { Note.from_latin("C0") }

        it "raises an exception" do
          lambda {
            subject.notes_in_range(start_note, "bar")
          }.should raise_exception(RBMusic::ArgumentError)
        end
      end

      context "when called with valid start and end notes" do
        let(:start_note) { Note.from_latin("C0") }
        let(:end_note) { Note.from_latin("C1") }
        let(:notes) { subject.notes_in_range(start_note, end_note) }

        it "is a NoteSet" do
          notes.should be_a(NoteSet)
        end
      end

    end

  end

end
