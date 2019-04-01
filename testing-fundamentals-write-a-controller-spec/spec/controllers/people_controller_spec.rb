require "rails_helper"

describe PeopleController do
  describe "#create" do
    context "when person is valid" do
      it "redirects to #show" do
        person = stub_person(true)
        allow(Person).to receive(:new).with(first_name: "John").and_return(person)
        allow(person).to receive(:save).and_return(true)
        post :create, person: {first_name: "John"}

        expect(Person).to have_received(:new)
        expect(person).to have_received(:save)
        expect(response).to redirect_to(person)
      end

    end

    context "when person is invalid" do
      it "renders the 'new' template" do
        person = stub_person(false)
        allow(Person).to receive(:new).with(first_name: "John").and_return(person)
        allow(person).to receive(:save).and_return(false)
        post :create, person: {first_name: "John"}

        expect(Person).to have_received(:new)
        expect(person).to have_received(:save)
        expect(response).to render_template(:new)
      end
    end

    def stub_person(result)
      Person.new.tap do |person|
        allow(Person).to receive(:new).and_return person
        allow(person).to receive(:save).and_return(result)
      end
    end

  end
end
