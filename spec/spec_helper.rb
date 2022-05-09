require 'rspec'
require 'pg'
require 'album'
require 'song'
require 'pry'

# shared code for clearing tests between runs & connecting to the DB:

DB = PG.connect({:dbname => 'record_store_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM albums *;")
    DB.exec("DELETE FROM songs *;")
  end
end