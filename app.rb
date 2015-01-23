require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/stylist')
require('./lib/client')
require('pg')

DB = PG.connect({:dbname => "hair_salon"})

get("/") do
  Stylist.remove_empty_name_entry()
  @stylists = Stylist.all()
  Client.remove_empty_name_entry()
  @clients = Client.all()
  erb(:index)
end


post("/stylists") do
  name = params.fetch("name")
  stylist = Stylist.new({:name => name, :id => nil})
  stylist.save()
  redirect("/")
end

get("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist_clients)
end

get("/stylists/:id/edit") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist_edit)
end

patch("/stylists/:id") do
  name = params.fetch("name")
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.update({:name => name})
  erb(:stylist_clients)
end

delete("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.delete()
  @stylists = Stylist.all()
  erb(:index)
end

post("/clients_index") do
  name = params.fetch("name")
  stylist_id = params.fetch("stylist_id").to_i()
  client = Client.new({:name => name, :stylist_id => stylist_id})
  client.save()
  @stylist = Stylist.find(stylist_id)
  redirect("/")
end

post("/clients") do
  name = params.fetch("name")
  stylist_id = params.fetch("stylist_id").to_i()
  client = Client.new({:name => name, :stylist_id => stylist_id})
  client.save()
  @stylist = Stylist.find(stylist_id)
  erb(:stylist_clients)
end

get("/clients/:id") do
  @client = Client.find(params.fetch("id").to_i())
  erb(:client_edit)
end


patch("/clients/:id") do
  name = params.fetch("name")
  @client = Client.find(params.fetch("id").to_i())
  @client.update({:name => name})
  stylist_id = @client.stylist_id()
  url = "/stylists/" + stylist_id.to_s()
  redirect(url)
end

delete("/clients/:id") do
  @client = Client.find(params.fetch("id").to_i())
  @client.delete()
  @clients = Client.all()
  stylist_id = @client.stylist_id()
  url = "/stylists/" + stylist_id.to_s()
  redirect(url)
end
