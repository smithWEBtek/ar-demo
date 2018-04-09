DATA_artists ={
 :artist_keys =>
		["name"],
  :artists => [
		["James Brown"],
		["Sly & The Family Stone"],
		["George Clinton"],
		["Earth, Wind, & Fire"],
		["Curtis Mayfield"],
		["Stevie Wonder"],
		["Isley Brothers"],
		["Kool & The Gang"],
		["Rick James"],
		["Isaac Hayes"]
	]
}

def make_artists
  DATA_artists[:artists].each do |artist|
    new_artist = Artist.new
    artist.each_with_index do |attribute, i|
      new_artist.send(DATA_artists[:artist_keys][i]+"=", attribute)
    end
    new_artist.save
  end
end

def main
  make_artists

end

main