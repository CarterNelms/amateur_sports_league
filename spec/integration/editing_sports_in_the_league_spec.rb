RSpec.describe "Editing existing sports in the league", :integration do
  context "with valid input" do
    let!(:sport){Sport.create(name: "Baseball")}
    let!(:output){run_program_with_input("edit", "1", "name", "Football", "end")}

    it "edits the sport in the league's database" do
      expect(Sport.count).to eq(1)
      expect(Sport.last.name).to eq("Football")
    end

    it "prints a success message" do
      expect(output).to include("Baseball's name has been changed from Baseball to Football")
    end
  end
end