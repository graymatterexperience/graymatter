feature 'Homepage Features' do
  before { visit root_path }

  # it won't run js code but it is fast
  xit do
    expect(page).to have_content 'Home'
  end

  # it will run js code
  xit '', :js do
    expect(page).to have_content 'Hello World'
  end

  # it will open Firefox
  # remove x from xit to run the test in Firefox on your machine to preview
  xit '', :selenium do
    expect(page).to have_content 'Hello World'
  end

  # it will open Chrome
  # remove x from xit to run the test in Chrome on your machine to preview
  xit '', :selenium_chrome do
    expect(page).to have_content 'Hello World'
  end
end
