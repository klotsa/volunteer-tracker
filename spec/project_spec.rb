require('spec_helper')

describe(Project) do
  describe('.all') do
    it('starts off with without projects') do
      expect(Project.all()).to(eq([]))
    end
  end
end
