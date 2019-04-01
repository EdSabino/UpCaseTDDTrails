require_relative "../lib/person"

describe Person do
  describe "#full_name" do
    it "returns the first and last names concatenated" do
      person = Person.new(first_name: "Dohn", last_name: "Joe")
      expect(person.full_name).to eq("Dohn Joe")
    end
  end
end
