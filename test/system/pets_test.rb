require "application_system_test_case"

class PetsTest < ApplicationSystemTestCase
  setup do
    @pet = pets(:one)
  end

  test "visiting the index" do
    visit pets_url
    assert_selector "h1", text: "Pets"
  end

  test "creating a Pet" do
    visit pets_url
    click_on "New Pet"

    fill_in "Age", with: @pet.age
    fill_in "Animal", with: @pet.animal
    fill_in "Breed", with: @pet.breed
    fill_in "Chip number", with: @pet.chip_number
    fill_in "Name", with: @pet.name
    fill_in "Sex", with: @pet.sex
    click_on "Create Pet"

    assert_text "Pet was successfully created"
    click_on "Back"
  end

  test "updating a Pet" do
    visit pets_url
    click_on "Edit", match: :first

    fill_in "Age", with: @pet.age
    fill_in "Animal", with: @pet.animal
    fill_in "Breed", with: @pet.breed
    fill_in "Chip number", with: @pet.chip_number
    fill_in "Name", with: @pet.name
    fill_in "Sex", with: @pet.sex
    click_on "Update Pet"

    assert_text "Pet was successfully updated"
    click_on "Back"
  end

  test "destroying a Pet" do
    visit pets_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pet was successfully destroyed"
  end
end
