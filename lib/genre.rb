class Genre
  
  extend Concerns::Findable

  attr_accessor :name

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    self.class.all << self
  end

  def songs
    @songs
  end

  def add_song(song)
    song.genre || song.genre = self
    unless songs.include?(song)
      songs << song
    end
  end

  def artists
    @songs.map { |i| i.artist }.uniq
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end
  def self.create(name)
    genre = self.new(name)
    genre.save
    genre
  end

end