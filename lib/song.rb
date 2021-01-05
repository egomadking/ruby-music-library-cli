require "pry"
class Song

  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    #binding.pry
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end

  def name=(name)
    @name = name
  end

  def save
    self.class.all << self
  end

  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end

  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end

  def self.new_from_filename(name)
    artist_name, song_name, genre_name = name.split(" - ")
    genre_name = genre_name.gsub(".mp3", "")

    artist = Artist.find_or_create_by_name(artist_name)
    genre = Genre.find_or_create_by_name(genre_name)

    song = self.new(song_name, artist, genre)
    song
    #binding.pry
  end

  def self.create_from_filename(name)
    song = self.new_from_filename(name)
    song.save
  end

  def self.all
    @@all
  end

  def self.create(name)
    song = self.new(name)
    song.save
    song
  end

  def self.destroy_all
    @@all.clear
  end

end