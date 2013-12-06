require "sinatra/activerecord/rake"
require "./app"
require "./user_setup"
require "octokit"
require "active_support/all"
require "dotenv"
require "pry"

if !File.file?(".env")
  initialize_user
end

Dotenv.load

Octokit.configure do |c|
  c.access_token = ENV['GITHUB_OAUTH_TOKEN']
end

Octokit.auto_paginate = true

task :default => :find_new_repos

task :find_new_repos do
  Repo.delete_all

  developers_from_location.first(10).each do |dev|
    repos = repos_for_dev(dev, 2.months.ago)

    repos.each do |repo|
      saved_repo = Repo.create(name: repo.full_name, 
                               description: repo.description,
                               created_at: repo.created_at)
      puts saved_repo.id
    end
  end

  puts "Found #{Repo.count} new repos."
end

def developers_from_location
  locations = ENV['GITHUB_LOCATION'].split(",").map { |e| e.strip }
  locations_query = locations.map { |location| "location:#{location}" } 
  locations_query = locations_query.join(", ")
  Octokit.search_users("#{locations_query} repos:>0").items 
end

def repos_for_dev(dev, time_since)
  Octokit.repos(dev.login, {sort: :created}).find_all {|repo| repo.created_at >= time_since && !repo.fork }
end
