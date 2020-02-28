require 'pg'

def upload(number)
  con = PG.connect :dbname => 'postgres', :user => 'a'
  res = con.exec "SELECT idraposa FROM raposas WHERE name = '#{number}.jpg'"

  if res.ntuples == 0
    encoder = PG::TextEncoder::Bytea.new
    bytea = encoder.encode(File.read("./yourFoxes/#{number}.jpg"))

    con.exec "INSERT INTO raposas VALUES (DEFAULT, '#{number}.jpg', '#{bytea}')"
  end
end

def upload_all
  con = PG.connect :dbname => 'postgres', :user => 'a'

  files = Dir.open('./yourFoxes').each_child
  files.each do |name|
    res = con.exec "SELECT idraposa FROM raposas WHERE name = '#{name}'"

    if res.ntuples == 0
      encoder = PG::TextEncoder::Bytea.new
      bytea = encoder.encode(File.read("./yourFoxes/#{name}"))

      con.exec "INSERT INTO raposas VALUES (DEFAULT, '#{name}', '#{bytea}')"
    end
  end
end


