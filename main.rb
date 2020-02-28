load 'fromAPI.rb'
load 'toBD.rb'
load 'fromBD.rb'

def list_my_foxes
  ret = []
  files = Dir.open('./yourFoxes').each_child
  files.each do |name|
    ret.append(name.sub! '.jpg', '')
  end
  ret.join(', ')
end

def commands
  puts "Welcome to the Fox Black Market\n" \
       "How can I help you?\n" \
       "1.  List your foxes\n" \
       "2.  Buy random fox\n" \
       "3.  Sell specific fox\n" \
       "4.  List all available foxes\n" \
       "5.  Buy all available foxes\n" \
       "6.  Sell all your foxes\n" \
       "/q. Leave market\n"
end

commands

while true
  input = gets

  case input
  when /^1\s/
    puts list_my_foxes
  when /^2\s/
    n = fromAPI
    puts "Bought fox #{n}"
  when /^3\s/
    puts "fox's number:"
    n = gets
    if n =~ /^\d+/
      upload(n[/^\d+/])
      puts "Sold fox #{n}"
    else
      puts "Unvalid number"
    end
  when /^4\s/
    puts list_all
  when /^5\s/
    download_all
    puts "Bought all available foxes"
  when /^6\s/
    upload_all
    puts "Sold all your foxes"
  when /^\s$/
    commands
  when %r{^/q}
    return
  else
    puts "Try again"
  end
end
