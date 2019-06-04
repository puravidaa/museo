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
  end

  def test_it_finds_photo_by_artist
    photo_1 = {
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

    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }

    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }

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

    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    @curator.add_photograph(photo_1)
    @curator.add_photograph(photo_2)
    @curator.add_photograph(photo_3)
    @curator.add_photograph(photo_4)
    @curator.add_artist(artist_1)
    @curator.add_artist(artist_2)
    @curator.add_artist(artist_3)

    diane_arbus = @curator.find_artist_by_id("3")
    assert_equal [photo_3, photo_4], @curator.find_photographs_by_artist(diane_arbus)
  end

  def test_it_finds_artists_with_multiple_photographs
    photo_1 = {
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

    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
    }

    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
    }

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

    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
    }

    @curator.add_photograph(photo_1)
    @curator.add_photograph(photo_2)
    @curator.add_photograph(photo_3)
    @curator.add_photograph(photo_4)
    @curator.add_artist(artist_1)
    @curator.add_artist(artist_2)
    @curator.add_artist(artist_3)

    diane_arbus = @curator.find_artist_by_id("3")
#=> #<Artist:0x00007fa3c13eef88 @born="1923", @country="United States", @died="1971", @id="3", @name="Diane Arbus">
    @curator.find_photographs_by_artist(diane_arbus)
#=> [#<Photograph:0x00007fa3c13a4050...>, #<Photograph:0x00007fa3c110e4a8...>]
    assert_equal [artist_3], @curator.artists_with_multiple_photographs(diane_arbus, "3")
#=> [#<Artist:0x00007fa3c13eef88 @born="1923", @country="United States", @died="1971", @id="3", @name="Diane Arbus">]
    assert_equal 1, @curator.artists_with_multiple_photographs.length
#=> 1
    assert diane_arbus == @curator.artists_with_multiple_photographs.first
#=> true
  end
end
