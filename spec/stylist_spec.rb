require('spec_helper')

describe(Stylist) do

  describe(".all") do
    it("starts off with no stylists") do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe('#name') do
    it("returns the stylist's name") do
      test_stylist = Stylist.new({ :name => "Kateri", :id => nil })
      expect(test_stylist.name()).to(eq("Kateri"))
    end
  end

  describe('#id') do
    it("sets the stylist's ID when you save their name to the database") do
      test_stylist = Stylist.new({:name => 'Kateri', :id => nil})
      test_stylist.save()
      expect(test_stylist.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save') do
    it('lets you save stylists to the database') do
      test_stylist = Stylist.new({:name => 'Kateri', :id => nil})
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe('#==') do
    it('is the same stylist if it has the same name') do
      stylist1 = Stylist.new({ :name => "Kateri", :id => nil} )
      stylist2 = Stylist.new({ :name => "Kateri", :id => nil} )
      expect(stylist1).to(eq(stylist2))
    end
  end

  describe('.find') do
    it('returns a stylist by its ID number') do
      test_stylist = Stylist.new({:name => "Kateri", :id => nil})
      test_stylist.save()
      test_stylist2 = Stylist.new({:name => 'Jemma', :id => nil})
      test_stylist2.save()
      expect(Stylist.find(test_stylist2.id())).to(eq(test_stylist2))
    end
  end

  describe('#clients') do
    it("returns a list of clients that belong to that stylist") do
      test_stylist = Stylist.new({ :name => "Kateri", :id => nil })
      test_stylist.save()
      client1 = Client.new({:name => 'Dakota', :due => '2015-01-20', :stylist_id => test_stylist.id()})
      client2 = Client.new({:name => 'Jasper', :due => '2015-01-21', :stylist_id => test_stylist.id()})
      client1.save()
      client2.save()
      expect(test_stylist.clients()).to(eq([client1, client2]))
    end

    it("returns a stylist of clients that belong to that stylist, sorted by due date") do
      test_stylist = Stylist.new({ :name => "Kateri", :id => nil })
      test_stylist.save()
      client1 = Client.new({:name => 'Dakota', :stylist_id => test_stylist.id()})
      client2 = Client.new({:name => 'Jasper', :stylist_id => test_stylist.id()})
      client3 = Client.new({:name => 'Clemintine', :stylist_id => test_stylist.id()})
      client1.save()
      client2.save()
      client3.save()
      expect(test_stylist.clients()).to(eq([client3, client2, client1]))
    end

  end

  describe('#delete') do
    it("deletes a stylist from database") do
      test_stylist = Stylist.new({ :name => "Kateri", :id => nil })
      test_stylist.save()
      test_stylist2 = Stylist.new({:name => 'Jemma', :id => nil})
      test_stylist2.save()
      test_stylist.delete()
      expect(Stylist.all()).to(eq([test_stylist2]))
    end
  end

  describe('.remove_empty_name_entry')
    it('deletes from the database instances where the user entered nothing into the name form box and still pressed add stylist button') do
      test_stylist = Stylist.new({ :name => "Kateri", :id => nil })
      test_stylist.save()
      test_stylist2 = Stylist.new({ :name => '', :id => nil })
      test_stylist2.save()
      Stylist.remove_empty_name_entry()
      expect(Stylist.all()).to(eq([test_stylist]))
  end
end
