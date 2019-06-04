require 'minitest/autorun'
require './lib/curator'
require 'minitest/pride'
require 'pry'

class ArtistTest < Minitest::Test
  def setup
    @curator = Curator.new
  end

  def test_it_exists
    assert_instance_of Curator, @curator
  end

  def test_it_has_attributes
    assert_equal [], @curator.artists
    assert_equal [], @curator.photographs
  end

  def test_it_adds_photos
    photo_1 = {
      # binding.pry
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }

    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }

    @curator.add_photograph(photo_1)
    @curator.add_photograph(photo_2)
    assert_equal [photo_1, photo_2], @curator.photographs
    assert_equal photo_1, @curator.photographs.first
    # assert_equal photo_1[:name], @curator.photographs.first.name
  end

  def test_it_adds_artists
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }

    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }

    @curator.add_artist(artist_1)
    @curator.add_artist(artist_2)

    assert_equal [artist_1, artist_2], @curator.artists
    assert_equal artist_1, @curator.artists.first
    # assert_equal "Henri Cartier-Bresson", @curator.artists.first.name
  end
  
  def test_it_finds_artist_by_id
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }

    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }

    @curator.add_artist(artist_1)
    @curator.add_artist(artist_2)

    assert_equal artist_1, @curator.find_artist_by_id("1")
  end

  def test_it_finds_photo_by_id
    photo_1 = {
      # binding.pry
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }

    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }

    @curator.add_photograph(photo_1)
    @curator.add_photograph(photo_2)

    assert_equal photo_2, @curator.find_photograph_by_id("2")
#=> #<Photograph:0x00007fd3a1801278 @artist_id="2", @id="2", @name="Moonrise, Hernandez", @year="1941">
  end
end
