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

  def self.find(id)
    found_project = nil
    Project.all().each() do |project|
      if project.id() == id
        found_project = project
      end
    end
    found_project
  end

  def volunteers
    project_volunteers = []
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id()};")
    volunteers.each() do |volunteer|
      id = volunteer.fetch("id").to_i()
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i()
      project_volunteers.push(Volunteer.new({:id => id, :name => name, :project_id => project_id}))
    end
    project_volunteers
  end

  def update(attributes)
    @id = self.id()
    @name = attributes[:name]
    DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
    DB.exec("DELETE FROM volunteers WHERE project_id = #{self.id()};")
  end
end
