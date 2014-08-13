RSpec.describe Sport do
  let!(:a){Sport.create(name: "Paintball")}

  it "should have many teams" do
    should have_many :teams
  end

  it "should save newly added sports to the database" do
    expect(Sport.last.name).to eq("Paintball")
  end

  it "should update edited values in the database" do
    a.name = "Airsoft"
    a.save!
    expect(Sport.last.name).to eq("Airsoft")
  end

  it "should be able to delete a sport from the database" do
    a.destroy
    expect(Sport.count).to eq(0)
  end
end