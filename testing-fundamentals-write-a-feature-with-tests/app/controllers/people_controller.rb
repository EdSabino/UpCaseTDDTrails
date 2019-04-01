class PeopleController < ApplicationController
  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_attributes)
    if @person.save
      redirect_to @person, notice: "Person created."
    else
      render :new
    end
  end

  def show
    find_person
  end

  def edit
    find_person
  end

  def update
    find_person
    if @person.update_attributes(person_attributes)
      redirect_to @person, notice: "Person updated"
    else
      render :edit
    end
  end

  private

  def person_attributes
    params.require(:person).permit(:first_name)
  end

  def find_person
    @person = Person.find(params[:id])
  end
end
