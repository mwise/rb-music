require_relative '../spec_helper'

describe "RBMusic Constants" do

  describe RBMusic::NOTE_NAMES do
    it "is correct" do
      subject.should == ["F", "C", "G", "D", "A", "E", "B"]
    end
  end

  describe RBMusic::ACCIDENTALS do
    it "is correct" do
      subject.should == ["bb", "b", "", "#", "x"]
    end
  end

  describe RBMusic::NOTES do
    it "contains a key for each note/accidental combination" do
      RBMusic::NOTE_NAMES.each do |note_name|
        ACCIDENTALS.each do |accidental|
          NOTES.should have_key("#{note_name}#{accidental}")
        end
      end
    end
  end

end
