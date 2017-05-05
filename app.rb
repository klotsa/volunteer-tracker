require('sinatra')
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker_test"})
