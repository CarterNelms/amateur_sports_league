RSpec.describe "Adding teams to the league", :integration do
  let!(:player){Player.create(username: "Greg", first_name: "Greg", last_name: "Jones", age: 37, is_male: 1)}
  let!(:sport){Sport.create(name: "Baseball")}
  
  context "with valid input" do
    let!(:output){run_program_with_input("Greg", "1", "add", "Red Dragons", "end")}

    it "adds a new team for the specified sport" do
      team = Team.last
      expect(team.name).to eq("Red Dragons")
    end

    it "prints a success message" do
      expect(output).to include("Red Dragons has been added")
    end
  end
end