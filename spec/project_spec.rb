require("spec_helper")

describe(Project) do
  describe(".all") do
    it("starts off with without projects") do
      expect(Project.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("names the task") do
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
      test_project = Project.new({:id => 1, :name => "paint the fence"})
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


end
