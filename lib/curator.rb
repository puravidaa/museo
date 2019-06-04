class Curator
  attr_reader :photographs, :artists
  def initialize
    @photographs = []
    @artists = []
  end

  def add_photograph(photo)
    @photographs << Photograph.new(photo)
  end

  def add_artist(artist)
    @artists << Artist.new(artist)
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
  # => 1) get artists_with_multiple photos
  # def artists_with_multiple_photographs
  #   artist_multiple_photos = []
  #   @artists.each do |artist|

  #     @photographs.each do |photograph|
  #       binding.pry
  #       count_of_photos = photograph.each do |photo|
  #         photo[:artist_id].count do |artist_id|
  #         artist_id
  #       end
  #       if photograph[:artist_id] == artist[:id] && count_of_photos > 1
  #         artist_multiple_photos << artist
  #       end
  #     end
  #   end
  #   artist_multiple_photos
  # end

  # multiple_photos = []
  # photo_count = 0
  # @artists.each do |artist|
  #   @photographs.each do |photo|
  #     # binding.pry
  #     if photo[:artist_id] == artist[:id]
  #       photo_count += 1
  #       if photo_count > 1
  #         multiple_photos << artist
  #       end
  #     end
  #   end
  # end
  # multiple_photos

  #    multiple_photos = []
  #    find_photographs_by_artist(artist).each do |photo|
  #     if photo.count > 1
  #       find_artist_by_id(id).each do |artist_with_id|
  #          if artist_with_id[1] == id
  #            multiple_photos << artist_with_id
  #          end
  #       end
  #     end
  #     multiple_photos
  #   end
  # end

# => photographs_taken_by_artist_from(string) -
  # => This method takes a String representing a country.
  # => It returns an Array of Photographs that were taken
  # => by a photographer from that country.

  def photographs_taken_by_artist_from(country)
    photos_by_country = []
    @photographs.each do |photo|
      @artists.each do |artist|
        if photo[:artist_id] == artist[:id] && artist[:country] == country
          photos_by_country << photo
        end
      end
    end
    photos_by_country
  end
end
