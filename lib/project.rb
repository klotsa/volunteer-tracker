class Project
  attr_reader(:id, :task)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetc(:name)
  end

  def self.all
    all_projects = DB.exec("SELECT * FROM projects;")
    saved_projects = []
    all_projects.each() do |project|
      id = project.fetch(:id)
      task = project.fetch(:task)
      each_project = Project.new({:id => id, :task => task})
      saved_projects.push(each_project)
    end
    saved_projects
  end
end
