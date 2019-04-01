require "rails_helper"

describe PeopleController do
  describe "#create" do
    context "when person is valid" do
      it "redirects to #show" do
        person = Person.create(first_name: "Bob")
        allow(person).to receive(:save).and_return(true)
        allow(Person).to receive(:new).
          with(first_name: "Bob").
          and_return(person)

        post :create, person: { first_name: "Bob" }

        expect(response).to redirect_to(person_path(person))
      end
    end

    context "when person is invalid" do
      it "redirects to #new" do
        person = double("person")
        allow(person).to receive(:save).and_return(false)
        allow(Person).to receive(:new).with(first_name: "").and_return(person)

        post :create, person: { first_name: "" }

        expect(response).to render_template(:new)
      end
    end
  end

  describe "#edit" do
    context "on edit" do
      it "find person" do
        person = double("person")
        allow(Person).to receive(:find).with("6").and_return(person)
        
        get :edit, id: 6

        expect(Person).to have_received(:find)
        expect(response).to render_template(:edit)
      end
    end

    context "on update" do
      it "when valid" do
        person = Person.create(first_name: "Bob")
        allow(Person).to receive(:find).with("6").and_return(person)
        allow(person).to receive(:update_attributes).with(first_name: "Cartarella").and_return(true)

        put :update, id: 6, person: {first_name: "Cartarella"}

        expect(Person).to have_received(:find)
        expect(person).to have_received(:update_attributes)
        expect(response).to redirect_to(person_path(person))
      end

      it "when invalid" do
        person = double("person")
        allow(Person).to receive(:find).with("6").and_return(person)
        allow(person).to receive(:update_attributes).with(first_name: "Cartarella").and_return(false)

        put :update, id: 6, person: {first_name: "Cartarella"}

        expect(Person).to have_received(:find)
        expect(person).to have_received(:update_attributes)
        expect(response).to render_template(:edit)
      end
    end
  end
end
