RSpec.describe "Viewing sports", :integration do
  context "with valid input" do
    let!(:sport){Sport.create(name: "Baseball")}
    let!(:output){run_program_with_input("1", "end")}

    it "prints the sport into the terminal" do
      header = <<EOS
==============
Baseball
==============
EOS
      expect(output).to include(header)
    end
  end
end