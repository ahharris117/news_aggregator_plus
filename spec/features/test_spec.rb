require "spec_helper"

# RSpec.describe "test" do
#   it "tests the test suite" do
#     expect(true).to eq true
#   end
# end

feature "user can navigate links and home page" do
  scenario "visit pages to check if content is there" do
    visit '/' 
    expect(page).to have_content('Your Home for TB News!')
  end

  scenario "user clicks articles link and navigates to that page" do
    visit '/'
    click_on 'Articles!'
    expect(page).to have_content('Article List')  
    expect(page).to have_current_path('/articles')
  end

  scenario "user clicks submit link and is brought to submit page" do
    visit '/'
    click_on 'Submit!'
    expect(page).to have_content('Submit your article!')
    expect(page).to have_current_path('/articles/new')
  end
end

feature "user adds an article" do 
  before(:each) do
    reset_csv
  end

  scenario "user adds a complete article" do 
    visit('/articles/new')
    fill_in "Title", with: "Great Title"
    fill_in "Description", with: "This is about"
    fill_in "URL", with: "https://google.com"
    
    click_button "submit"

    expect(page).to have_current_path('/articles')
    expect(page).to have_content('Great Title')
    expect(page).to have_content('This is about')
    expect(page).to have_content('link')
  end

  scenario "user omits title" do
    visit('/articles/new')
    fill_in "Title", with: ""
    fill_in "Description", with: "This is about"
    fill_in "URL", with: "https://google.com"

    click_button "submit"

    expect(page).to have_current_path('/articles/new')
    expect(page).to have_content('Error fill out all fields!')
  end

end