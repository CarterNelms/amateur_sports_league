RSpec.describe Player do
  let!(:a){Player.create(username: "Stryke3", first_name: "Ted", last_name: "Stryker", age: 37, is_male: 1)}

  it "should have many memberships" do
    should have_many :memberships
  end

  it "should have many teams through memberships" do
    should have_many(:teams).through(:memberships)
  end

  it "should have many sports through teams" do
    should have_many(:sports).through(:teams)
  end

  it "should save newly added players to the database" do
    expect(Player.count).to eq(1)
    expect(Player.last.username).to eq("Stryke3")
    expect(Player.last.first_name).to eq("Ted")
    expect(Player.last.last_name).to eq("Stryker")
    expect(Player.last.age).to eq(37)
    expect(Player.last.is_male).to eq(1)
  end

  it "should update edited values in the database" do
    a.age = 38
    a.save!
    expect(Player.last.age).to eq(38)
  end

  it "should be able to delete a player from the database" do
    a.destroy
    expect(Player.count).to eq(0)
  end
end