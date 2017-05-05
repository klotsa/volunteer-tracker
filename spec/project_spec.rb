require("spec_helper")

describe(Project) do
  describe(".all") do
    it("starts off with without projects") do
      expect(Project.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("names the project") do
      test_project = Project.new({:id => nil, :name => "paint the fence"})
      expect(test_project.name)
    end
  end

  describe("#id") do
    it("tells the id") do
      test_project = Project.new({:id => nil, :name => "paint the fence"})
      test_project.save()
      expect(test_project.id()).to(be_an_instance_of (Fixnum))
    end
  end

  describe("#save") do
    it ("saves the projects into the db") do
      test_project = Project.new({:id => nil, :name => "paint the fence"})
      test_project.save()
      expect(Project.all()).to(eq([test_project]))
    end
  end

  describe("#==") do
   it("is the same project if it has the same name + id") do
     test_project1 = Project.new({:id => nil, :name => "paint the fence"})
     test_project2 = Project.new({:id => nil, :name => "paint the fence"})
     expect(test_project1).to eq(test_project2)
   end
 end

 describe(".find") do
    it("returns a project by its ID") do
      test_project = Project.new({:id => nil, :name => "paint the fence"})
      test_project.save()
      test_project2 = Project.new({:id => nil, :name => "wash the wall"})
      test_project2.save()
      expect(Project.find(test_project2.id())).to(eq(test_project2))
    end
  end

  describe("#volunteers") do
    it("returns an array with all volunteers at this projects") do
      test_project = Project.new({:id => nil, :name => "paint the fence"})
      test_project.save()
      new_volunteer = Volunteer.new({:name => "Tom Sawyer", :project_id => test_project.id()})
      new_volunteer.save()
      new_volunteer2 = Volunteer.new({:name => "Ben Rogers", :project_id => test_project.id()})
      new_volunteer2.save()
      expect(test_project.volunteers()).to(eq([new_volunteer, new_volunteer2]))
    end
  end

  describe('#update') do
   it('lets you update projects in the database') do
     test_project = Project.new({:id => nil, :name => "paint the fence"})
     test_project.save()
     test_project.update({:name => 'plant the tree'})
     expect(test_project.name()).to(eq('plant the tree'))
   end
 end

 describe('#delete') do
   it('lets you delete a project from the database') do
     test_project = Project.new({:id => nil, :name => "paint the fence"})
     test_project.save()
     test_project2 = Project.new({:id => nil, :name => "wash the walls"})
     test_project2.save()
     test_project.delete()
     expect(Project.all()).to(eq([test_project2]))
   end

   it('deletes volunteers from the database') do
     test_project = Project.new({:id => nil, :name => "paint the fence"})
     test_project.save()
     new_volunteer = Volunteer.new({:name => "Tom Sawyer", :project_id => test_project.id()})
     new_volunteer.save()
     new_volunteer2 = Volunteer.new({:name => "Huck Finn", :project_id => test_project.id()})
     new_volunteer2.save()
     test_project.delete()
     expect(Volunteer.all()).to(eq([]))
   end
 end

end
