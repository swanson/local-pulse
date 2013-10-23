def prompt(*args)
  print(*args)
  gets
end

def initialize_user
  username = prompt("Please enter your GitHub username. ")
  password = prompt("Please enter your GitHub password. ")
  location = prompt("Please enter the location(s) of desired repos. ")

  File.open(".env", "w") do |file|
    file.puts "GITHUB_USERNAME=#{username}"
    file.puts "GITHUB_PASSWORD=#{password}"
    file.puts "GITHUB_LOCATION=#{location}"
  end
end
