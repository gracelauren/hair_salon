require('spec_helper')

describe(Client) do

  describe('#==') do
    it('is the same client if it has the same name') do
      client1 = Client.new({:name => 'Fiona', :stylist_id => 1})
      client2 = Client.new({:name => 'Fiona', :stylist_id => 1})
      expect(client1).to(eq(client2))
    end
  end

  describe('.all') do
    it("starts off with no clients") do
      expect(Client.all()).to(eq([]))
    end

    it("orders clients alphabetically") do
      test_client = Client.new({:name => 'Fiona', :stylist_id => 1})
      test_client.save()
      test_client2 = Client.new({:name => 'Amandine', :stylist_id => 1})
      test_client2.save()
      expect(Client.all()).to(eq([test_client2, test_client]))
    end
  end

  describe('#save') do
    it('adds a client to the array of saved clients') do
      test_client = Client.new({:name => 'Fiona', :stylist_id => 1})
      test_client.save()
      expect(Client.all()).to(eq([test_client]))
    end
  end

  describe('#delete') do
    it("deletes client from database") do
      test_client = Client.new({:name => 'Fiona', :stylist_id => 1})
      test_client.save()
      test_client2 = Client.new({:name => 'Amandine', :stylist_id => 1})
      test_client2.save()
      test_client.delete()
      expect(Client.all()).to(eq([test_client2]))
    end
  end

  describe('.find') do
    it('returns a client by its ID number') do
      test_client = Client.new({:name => 'Fiona', :stylist_id => 1})
      test_client.save()
      test_client2 = Client.new({:name => 'Amandine', :stylist_id => 1})
      test_client2.save()
      expect(Client.find(test_client2.id())).to(eq(test_client2))
    end
  end

  describe('.remove_empty_name_entry')
  it('deletes from the database instances where the user entered nothing into the name form box and still pressed add client button') do
    test_client = Client.new({ :name => "Fiona", :stylist_id => 1})
    test_client.save()
    test_client2 = Client.new({ :name => '', :stylist_id => 1})
    test_client2.save()
    Client.remove_empty_name_entry()
    expect(Client.all()).to(eq([test_client]))
  end
end
