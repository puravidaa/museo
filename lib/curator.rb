class Curator
  attr_reader :photographs, :artists
  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs << photo
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist[:id] == id
    end
  end

  def find_photograph_by_id(id)
    @photographs.find do |photo|
      photo[:id] == id
    end
  end

# => find_photographs_by_artist(artist) -
  # => This method takes an Artist object and returns an Array of all the Artist's photographs.
  # => A Photograph is linked to an Artist by its artist_id
  def find_photographs_by_artist(artist)
    artist_photos = []
    @photographs.each do |photograph|
      if photograph[:artist_id] == artist[:id]
        artist_photos << photograph
      end
    end
    artist_photos
  end



# => artists_with_multiple_photographs -
  # => This method returns an Array of all Artists who have more than one photograph
# => photographs_taken_by_artist_from(string) -
  # => This method takes a String representing a country.
  # => It returns an Array of Photographs that were taken by a photographer from that country.
end
