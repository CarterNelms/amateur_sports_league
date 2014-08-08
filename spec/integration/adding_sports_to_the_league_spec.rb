RSpec.describe "Adding sports to the league", :integration do
  context "with valid input" do
    let!(:output){run_program_with_input("add", "Baseball", "end")}

    it "adds a new sport to the league's database" do
      expect(Sport.last.name).to eq("Baseball")
    end

    it "prints a success message" do
      expect(output).to include("Baseball has been added")
    end
  end
end