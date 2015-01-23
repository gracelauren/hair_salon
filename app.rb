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
