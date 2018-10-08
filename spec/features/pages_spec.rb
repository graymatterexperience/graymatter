require 'rails_helper'
include SignIn

RSpec.describe 'Homepage Features', type: :feature do
  let(:student) { create(:student_user) }

  describe 'When user is logging into the application' do
    before { visit root_path }

    it 'User must be logged in to view this page' do
      expect(page).to have_content "You must be logged in"
    end

    it 'User enters correct credintials' do
      fill_in 'Email', with: student.email
      fill_in 'Password', with: student.password
      click_button 'Log in'

      expect(page).to have_content "Welcome #{student.first_name}"
      expect(page).to have_content student.name.to_s
      expect(page).to have_content 'Student'
    end

    it 'User does NOT enter correct credintials' do
      fill_in 'Email', with: student.email
      fill_in 'Password', with: nil
      click_button 'Log in'

      expect(page).to have_content "invalid email/password combination"
    end
  end
  # it will run js code
  xit '', :js do
    expect(page).to have_content 'Hello World'
  end

  # it will open Firefox
  describe 'open in different browers' do
    before { visit root_path }
    it 'User enters correct credintials in Firefox', :selenium do
      fill_in 'Email', with: student.email
      fill_in 'Password', with: student.password
      click_button 'Log in'

      expect(page).to have_content "Welcome #{student.first_name}"
      expect(page).to have_content student.name.to_s
      expect(page).to have_content 'Student'
    end

    # it will open Chrome
    it 'User enters correct credintials in Chrome', :selenium_chrome do
      fill_in 'Email', with: student.email
      fill_in 'Password', with: student.password
      click_button 'Log in'

      expect(page).to have_content "Welcome #{student.first_name}"
      expect(page).to have_content student.name.to_s
      expect(page).to have_content 'Student'
    end
  end
end
