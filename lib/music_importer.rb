require "pry"

class MusicImporter

  attr_accessor :path, :music_files

  def initialize(path)
    @path = path
  end

  def files
    @music_files = Dir.glob("#{@path}/*.mp3")
    @music_files.map do |file|
      file.gsub("#{@path}/", "")
    end
  end

  def import
    files.each do |filename|
      Song.create_from_filename(filename)
    end
  end

end