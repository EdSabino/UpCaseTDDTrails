require "rails_helper"

feature "user creates person valid" do
  scenario "with valid data" do
    visit new_person_url

    fill_in "First name", with: "John"

    click_button "Create Person"

    expect(page).to have_content("Person created.")
    expect(page).to have_content("John")
  end
end
