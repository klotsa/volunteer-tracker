require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new project', {:type => :feature}) do
  it('allows a user to click a project to see the volunteers') do
    visit('/')
    click_link('Add a new project')
    fill_in('name', :with =>'test')
    click_button('Add')
    expect(page).to have_content('Success!')
  end
end

describe('viewing all of the projects', {:type => :feature}) do
  it('allows a user to see all of the projects that have been created') do
    project = Project.new({:name => 'test', :id => nil})
    project.save()
    visit('/')
    click_link('View all projects')
    expect(page).to have_content(project.name)
  end
end

describe('seeing details for a single project', {:type => :feature}) do
  it('allows a user to click a project to see the volunteers') do
    test_project = Project.new({:name => 'test project',:id => nil})
    test_project.save()
    test_volunteer = Volunteer.new({:name => "Bob", :project_id => test_project.id()})
    test_volunteer.save()
    visit('/projects')
    click_link(test_project.name())
    expect(page).to have_content(test_volunteer.name())
  end
end

describe('adding volunteers to a project', {:type => :feature}) do
  it('allows a user to add a volunteer to a project') do
    test_project = Project.new({:name => 'test project',:id => nil})
    test_project.save()
    visit("/projects/#{test_project.id()}")
    fill_in("name", {:with => "Bob"})
    click_button("Add a volunteer")
    expect(page).to have_content("Here are all the volunteers in this project:")
  end
end
