RSpec.describe Membership do
  let!(:sport){Sport.create(name: "Paintball")}
  let!(:team){Team.create(name: "Gray Foxes")}
  let!(:player){Player.create(username: "Stryke3", first_name: "Ted", last_name: "Stryker", age: 37, is_male: 1)}
  let!(:membership){Membership.create(team: team, player: player)}

  it "should belong to a team" do
    should belong_to :team
  end

  it "should belong to a player" do
    should belong_to :player
  end

  it "should save newly added memberships to the database" do
    expect(Membership.last.team_id).to eq(team.id)
    expect(Membership.last.player_id).to eq(player.id)
  end

  it "should update edited values in the database" do
    player2 = Player.create(username: "Stryke4", first_name: "Ted", last_name: "Stryker", age: 37, is_male: 1)
    membership.player = player2
    membership.save!
    expect(Membership.last.player_id).to eq(player2.id)
  end

  it "should be able to delete a membership from the database" do
    membership.destroy
    expect(Membership.count).to eq(0)
  end
end