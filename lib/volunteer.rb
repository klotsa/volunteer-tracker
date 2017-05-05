
class Volunteer
  attr_accessor(:id, :name, :project_id)

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @project_id = attributes[:project_id]
  end

  def ==(other)
    self.id() == other.id() && self.name() == other.name() && self.project_id() == other.project_id()
  end

  def self.all
    database_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    database_volunteers.each() do |volunteer|
      name = volunteer['name']
      id = volunteer['id'].to_i()
      project_id = volunteer['project_id'].to_i()
      volunteers.push(Volunteer.new({:id => id, :name => name, :project_id => project_id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  def self.find(id)
    found_volunteer = nil
    Volunteer.all().each() do |volunteer|
      if volunteer.id() == id.to_i()
        found_volunteer = volunteer
      end
    end
    found_volunteer
  end

  def project
    project = DB.exec("SELECT * FROM projects WHERE id = #{self.project_id()}")
    id = project.first().fetch('id').to_i()
    name = project.first().fetch('name')
    assigned_project = Project.new({:id => id, :name => name})
    assigned_project
  end

end
