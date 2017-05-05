require('spec_helper')

describe(Volunteer) do

  describe('.all') do
    it('is empty at first') do
      expect(Volunteer.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("lets enter a volunteer's name") do
      test_volunteer = Volunteer.new({:name => "Bob", :project_id => 1})
      expect(test_volunteer.name()).to(eq("Bob"))
    end
  end

  describe('#project_id') do
    it('allows getting the project ID out') do
      test_volunteer = Volunteer.new({:name => "Bob",  :project_id => 1})
      expect(test_volunteer.project_id()).to(eq(1))
    end
  end

  describe('#==') do
    it('is the same volunteer if it has the same description') do
      volunteer1 = Volunteer.new({:name => "Bob",  :project_id =>1})
      volunteer2 = Volunteer.new({:name => "Bob",  :project_id =>1})
      expect(volunteer1).to(eq(volunteer2))
    end
  end

  describe('#save') do
    it("add a volunteer to the array of saved volunteers") do
      test_volunteer = Volunteer.new({:name => "Bob", :project_id =>1})
      test_volunteer.save()
      expect(Volunteer.all()).to(eq([test_volunteer]))
    end
  end

end
