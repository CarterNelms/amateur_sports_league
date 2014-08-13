RSpec.describe "Viewing sports", :integration do
  let!(:player){Player.create(username: "Greg", first_name: "Greg", last_name: "Jones", age: 37, is_male: 1)}
  let!(:sport){Sport.create(name: "Baseball")}
  
  context "with valid input" do
    let!(:output){run_program_with_input("Greg", "1", "end")}

    it "prints the sport into the terminal" do
      header = <<EOS
==============
Baseball
TEAMS
==============
EOS
      expect(output).to include(header)
    end
  end
end