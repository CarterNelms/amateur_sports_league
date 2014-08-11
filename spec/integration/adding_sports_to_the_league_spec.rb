RSpec.describe "Adding sports to the league", :integration do
  context "with valid input" do
    let!(:output){run_program_with_input("add", "Baseball", "9", "15", "4", "16", "end")}

    it "adds a new sport to the league's database" do
      sport = Sport.last
      expect(sport.name).to eq("Baseball")
      expect(sport.minimum_team_size).to eq(9)
      expect(sport.maximum_team_size).to eq(15)
      expect(sport.minimum_number_of_teams).to eq(4)
      expect(sport.maximum_number_of_teams).to eq(16)
    end

    it "prints a success message" do
      expect(output).to include("Baseball has been added")
    end
  end
end