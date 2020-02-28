require 'unirest'
require 'down'

def fromAPI
  response = Unirest.post "https://randomfox.ca/floof/"
  number = response.body["image"].to_s[/\d+/]

  unless File.exist?("./yourFoxes/#{number}.jpg")
    Down.download(response.body["image"].to_s, destination: "./yourFoxes/#{number}.jpg")
  end

  number
end