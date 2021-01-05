require "pry"
class Artist
  
  extend Concerns::Findable

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def songs
    @songs
  end

  def save
    @@all << self
  end

  def add_song(song)
    song.artist || song.artist = self
    unless songs.include?(song)
      songs << song
    end
  end

  def genres
    @songs.map { |i| i.genre }.uniq
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    artist = self.new(name)
    artist.save
    artist
  end
end