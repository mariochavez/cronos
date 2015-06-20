require 'test_helper'

feature 'Add Time Track' do
  before do
    Capybara.current_driver = Capybara.javascript_driver
  end

  after do
    Capybara.current_driver = Capybara.default_driver
  end

  scenario 'sanity' do
    visit root_path

    page.must_have_content 'Blog project'
  end

  scenario 'display project info' do
    visit root_path
    click_link 'Blog project'

    page.must_have_selector '#new_time_track'
  end

  scenario 'display error when submitting empty form' do
    visit root_path
    click_link 'Blog project'

    within('#new_time_track') do
      click_button 'Crear Actividad'
    end

    page.must_have_content 'Por favor revise los datos de la forma'
  end

  scenario 'track new time entry' do
    visit root_path
    click_link 'Blog project'

    within('#new_time_track') do
      select 'Write post', from: 'Tarea'
      fill_in 'Tiempo', with: '3'
      click_button 'Crear Actividad'
    end

    page.wont_have_content 'Por favor revise los datos de la forma'
    page.must_have_content 'Write post'
    page.must_have_content '3.0 hrs'
  end
end
