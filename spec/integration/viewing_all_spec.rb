RSpec.describe "Viewing all", :integration do
  let!(:player){Player.create(username: "Greg", first_name: "Greg", last_name: "Jones", age: 37, is_male: 1)}
  let!(:sport){Sport.create(name: "Baseball")}
  let!(:team){Team.create(name: "Face Punchers")}

  context "sports" do
    let!(:output){run_program_with_input("Greg", "sports", "end")}

    it "should print out all sports in the league" do
      content = <<EOS
==============
SPORTS
==============
1. Baseball
EOS
      expect(output).to include(content)
    end
  end

  context "teams" do
    let!(:output){run_program_with_input("Greg", "teams", "end")}

    it "should print out all sports in the league" do
      content = <<EOS
==============
TEAMS
==============
1. Face Punchers
EOS
      expect(output).to include(content)
    end
  end

  context "players" do
    let!(:output){run_program_with_input("Greg", "players", "end")}

    it "should print out all sports in the league" do
      content = <<EOS
==============
PLAYERS
==============
1. Greg Jones
EOS
      expect(output).to include(content)
    end
  end
end