RSpec.describe Team do
  let!(:a){Team.create(name: "Red Dragons")}

  it "should belong to a sport" do
    should belong_to :sport
  end

  it "should have many memberships" do
    should have_many :memberships
  end

  it "should have many players through memberships" do
    should have_many(:players).through(:memberships)
  end

  it "should have one captain, which is indicated by a membership" do
    should have_one :captain
  end

  it "should save newly added teams to the database" do
    expect(Team.count).to eq(1)
    expect(Team.last.name).to eq("Red Dragons")
  end

  it "should update edited values in the database" do
    a.name = "Teal Iguanas"
    a.save!
    expect(Team.last.name).to eq("Teal Iguanas")
  end

  it "should be able to delete a team from the database" do
    a.destroy
    expect(Team.count).to eq(0)
  end
end