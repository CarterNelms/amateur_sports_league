RSpec.describe "Deleting sports from the league", :integration do
  let!(:player){Player.create(username: "Greg", first_name: "Greg", last_name: "Jones", age: 37, is_male: 1)}
  let!(:sport){Sport.create(name: "Baseball")}

  context "with valid input using sport index" do
    let!(:output){run_program_with_input("Greg", "delete", "1", "y", "end")}

    it "deletes the sport from the league's database" do
      expect(Sport.count).to eq(0)
    end

    it "prints a success message" do
      expect(output).to include("Baseball has been deleted")
    end
  end

  context "with valid input using sport name" do
    let!(:output){run_program_with_input("Greg", "delete", "Baseball", "y", "end")}

    it "deletes the sport from the league's database" do
      expect(Sport.count).to eq(0)
    end

    it "prints a success message" do
      expect(output).to include("Baseball has been deleted")
    end
  end

  context "with invalid input" do
    let!(:output1){run_program_with_input("Greg", "delete", "Basebal", "end")}
    let!(:output2){run_program_with_input("Greg", "delete", "2", "end")}

    it "does not delete the sport from the league's database" do
      expect(Sport.count).to eq(1)
      expect(Sport.last.name).to eq("Baseball")
    end

    it "prints an error message" do
      expect(output1).to include("That is not a valid selection")
      expect(output2).to include("That is not a valid selection")
    end
  end
end