RSpec.describe "Editing existing sports in the league", :integration do
  context "with valid input using names" do
    let!(:sport){Sport.create(name: "Baseball")}
    let!(:output){run_program_with_input("edit", "Baseball", "Name", "Football", "end")}

    it "edits the sport in the league's database" do
      expect(Sport.count).to eq(1)
      expect(Sport.last.name).to eq("Football")
    end

    it "prints a success message" do
      expect(output).to include("Baseball's name has been changed from Baseball to Football")
    end
  end

  context "with valid input using indexes" do
    let!(:sport){Sport.create(name: "Baseball")}
    let!(:output){run_program_with_input("edit", "1", "1", "Football", "end")}

    it "edits the sport in the league's database" do
      expect(Sport.count).to eq(1)
      expect(Sport.last.name).to eq("Football")
    end

    it "prints a success message" do
      expect(output).to include("Baseball's name has been changed from Baseball to Football")
    end
  end

  context "with invalid input" do
    let!(:sport){Sport.create(name: "Baseball")}
    let!(:output1){run_program_with_input("edit", "Baseball", "nam", "Football", "end")}
    let!(:output2){run_program_with_input("edit", "1", "0", "Football", "end")}

    it "does not edit the sport in the league's database" do
      expect(Sport.count).to eq(1)
      expect(Sport.last.name).to eq("Baseball")
    end

    it "prints an error message" do
      expect(output1).to include("That is not a valid attribute")
      expect(output2).to include("That is not a valid attribute")
    end
  end
end