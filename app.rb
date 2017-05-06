require('sinatra')
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker_test"})


get("/") do
  erb(:index)
end

get("/projects/new") do
  erb(:project_form)
end

post("/projects_form") do
  name = params.fetch("name")
  project = Project.new({:name => name, :id => nil})
  project.save()
  erb(:success)
 end

 get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

get('/volunteers') do
 @volunteers = Volunteer.all()
 erb(:volunteers)
end

get('/volunteers/:id/edit') do
  @volunteer = Volunteer.find(params['id'].to_i())
  erb(:volunteer_edit)
end

delete("/volunteers/:id") do
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  @volunteer.delete()
  @volunteers = Volunteer.all()
  erb(:index)
end

get("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  erb(:project)
end

post("/volunteers") do
  name = params.fetch("name")
  project_id = params.fetch("project_id").to_i()
  @project = Project.find(project_id)
  @volunteer = Volunteer.new({:name => name, :project_id => project_id})
  @volunteer.save()
  erb(:project)
end

get('/projects/:id/edit') do
  @project = Project.find(params['id'].to_i())
  erb(:project_edit)
end

patch('/projects/:id') do
  name = params['name']
  @project = Project.find(params['id'].to_i())
  @project.update({:name => name})
  erb(:project)
end

delete("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @project.delete()
  @projects = Project.all()
  erb(:index)
end
