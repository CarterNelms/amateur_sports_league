RSpec.describe Sport do
  it "should have many teams" do
    pending("create teams before running this test")
    should have_many :team
  end

  it "should save newly added sports to the database" do
    a = Sport.create(name: "Paintball")
    expect(Sport.last.name).to eq("Paintball")
  end
end