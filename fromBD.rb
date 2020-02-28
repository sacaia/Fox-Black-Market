require 'pg'

def download_all
  con = PG.connect :dbname => 'postgres', :user => 'a'
  res = con.exec "SELECT name, bytes FROM raposas"

  (0...res.ntuples).each do |i|
    unless File.exist?("./yourFoxes/#{res[i]['name']}")
      f = File.new("./yourFoxes/#{res[i]['name']}", "w")

      decoder = PG::TextDecoder::Bytea.new
      f.write(decoder.decode(res[i]['bytes']))
    end
  end
end

def list_all
  con = PG.connect :dbname => 'postgres', :user => 'a'
  res = con.exec "SELECT name FROM raposas"

  ret = []
  (0...res.ntuples).each do |i|
    ret[i] = res[i]['name'].sub! '.jpg', ''
  end

  ret.join(', ')
end