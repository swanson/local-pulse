require "sinatra/activerecord/rake"
require "./app"

require "octokit"
require "active_support/all"
require "dotenv"

Dotenv.load

Octokit.configure do |c|
  c.login = 'swanson'
  c.password = ENV['GITHUB_PASSWORD']
end

Octokit.auto_paginate = true

desc "Task description"
task :find_new_repos do
  Repo.delete_all

  developers_from_indy.first(10).each do |dev|
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

def developers_from_indy
  Octokit.search_users("location:Indiana location:Indianapolis repos:>0").items
end

def repos_for_dev(dev, time_since)
  Octokit.repos(dev.login, {sort: :created}).find_all {|repo| repo.created_at >= time_since && !repo.fork }
end