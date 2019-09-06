require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content 'Sign up'
  end

  feature "signing up a user" do
    
    scenario "redirects to bands index page after signup" do
      create_user("test@email.com", "password")
      expect(current_path).to eq("/bands")
      expect(page).to have_content 'All the Bands'
    end
  end

  feature "with an invalid user" do
    scenario "re-renders the signup page after failed signup" do
      create_user("test@email.com", "pass")
      expect(current_path).to eq("/users")
      expect(page).to have_content 'Password is too short'
    end
  end
end