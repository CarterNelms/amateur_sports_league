RSpec.describe "Deleting sports from the league", :integration do
  context "with valid input" do
    let!(:sport){Sport.create(name: "Baseball")}
    let!(:output){run_program_with_input("delete", "1", "y", "end")}

    it "deletes the sport from the league's database" do
      expect(Sport.count).to eq(0)
    end

    it "prints a success message" do
      expect(output).to include("Baseball has been deleted")
    end
  end
end