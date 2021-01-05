class MusicLibraryController

  def initialize(path = "./db/mp3s")
    session = MusicImporter.new(path)
    session.import
  end

  def call
    resp = ""
    while resp != "exit"
      puts("Welcome to your music library!")
      puts("To list all of your songs, enter 'list songs'.")
      puts("To list all of the artists in your library, enter 'list artists'.")
      puts("To list all of the genres in your library, enter 'list genres'.")
      puts("To list all of the songs by a particular artist, enter 'list artist'.")
      puts("To list all of the songs of a particular genre, enter 'list genre'.")
      puts("To play a song, enter 'play song'.")
      puts("To quit, type 'exit'.")
      puts("What would you like to do?")
      resp = gets.chomp
      case resp
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end
    end

  end

  def list_songs
    @songs = Song.all.sort { |a, b| a.name <=> b.name }
    @songs.each_with_index do |song, i|
      #binding.pry
      puts "#{i + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    artists = Artist.all.map { |artist| artist.name}.uniq
    artists = artists.sort { |a, b| a <=> b }
    artists.each_with_index do |artist, i|
      puts "#{i + 1}. #{artist}"
    end
  end

  def list_genres
    genres = Genre.all.map { |genre| genre.name}.uniq
    genres = genres.sort { |a, b| a <=> b }
    genres.each_with_index do |genre, i|
      puts "#{i + 1}. #{genre}"
    end
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    resp = gets.chomp
    artist = Artist.find_by_name(resp)
    if artist
      songs = artist.songs.sort{ |a, b| a.name <=> b.name }
      songs.each_with_index do |song, i|
        puts "#{i + 1}. #{song.name} - #{song.genre.name}"
      end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    resp = gets.chomp
    genre = Genre.find_by_name(resp)
    if genre
      songs = genre.songs.sort {|a, b| a.name <=> b.name }
      songs.each_with_index do |song, i|
        puts "#{i + 1}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
    puts("Which song number would you like to play?")
    resp = gets.strip.to_i
    if resp <= Song.all.length && resp > 0
      #binding.pry
      song = Song.all.sort { |a,b| a.name <=> b.name }[resp - 1]
      if song
        puts "Playing #{song.name} by #{song.artist.name}"
      end
    end
  end

end