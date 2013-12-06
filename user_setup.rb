require "octokit"

def prompt(*args)
  print(*args)
  gets.chomp
end

def initialize_user
  username = prompt("Please enter your GitHub username. ")
  password = prompt("Please enter your GitHub password. ")
  location = prompt("Please enter the location(s) of desired repos. ")

  oauth_token = Octokit::Client.new(:login => username, :password => password) \
      .create_authorization(:note => "local-pulse")[:token]

  File.open(".env", "w") do |file|
    file.puts "GITHUB_OAUTH_TOKEN=#{oauth_token}"
    file.puts "GITHUB_LOCATION=#{location}"
  end
end
