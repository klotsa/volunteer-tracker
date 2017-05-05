class Project
  attr_reader(:id, :name)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
  end

  def self.all
    all_projects = DB.exec("SELECT * FROM projects;")
    saved_projects = []
    all_projects.each() do |project|
      id = project.fetch("id").to_i
      name = project.fetch("name")
      saved_projects.push(Project.new({:id => id, :name => name}))
    end
    saved_projects
  end

  def save
    result = DB.exec("INSERT INTO projects (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(test_project)
    (self.id() == test_project.id()) && (self.name() == test_project.name())
  end
end
