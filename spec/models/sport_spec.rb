RSpec.describe Sport do
  it "should have many teams" do
    pending("create teams before running this test")
    should have_many :team
  end

  it "should save newly added sports to the database" do
    a = Sport.create(name: "Paintball")
    expect(Sport.last.name).to eq("Paintball")
  end

  it "should update edited values in the database" do
    a = Sport.create(name: "Paintball")
    a.name = "Airsoft"
    a.save!
    expect(Sport.last.name).to eq("Airsoft")
  end

  it "should be able to delete a sport from the batabase" do
    a = Sport.create(name: "Paintball")
    a.destroy
    expect(Sport.count).to eq(0)
  end
end