require "spec_helper"

describe Person do
  it "invalid without first name" do
    person = Person.new()
    expect(person).to be_invalid
    expect(person.errors.messages).to include(first_name: ["can't be blank"])
  end

  it "invalid with first_name blank" do
    person = Person.new(first_name: "")
    expect(person).to be_invalid
    expect(person.errors.messages).to include(first_name: ["can't be blank"])
  end

  it "expect to be valid with first name" do
    person = Person.new(first_name: "Something")
    expect(person).to be_valid
  end
end
