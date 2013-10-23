require "sinatra"
require "sinatra/activerecord"

set :database, "sqlite3:///test.sqlite3"

class Repo < ActiveRecord::Base

end

get "/" do
  @repos = Repo.all.order("created_at desc")
  erb :index
end

