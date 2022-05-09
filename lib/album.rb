class Album
  attr_reader :id
  attr_accessor :name
  

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all()
    @@albums.values()
  end

  def save()
    @@albums[self.id] = Album.new(self.name, self.id)
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.clear()
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  def update(name)
    @name = name
  end

  def delete()
    @@albums.delete(self.id)
  end

  def songs()
    Song.find_by_album(self.id)
  end

  def self.search(str)
    # @@albums.find_all {|album| album[1].name == str}
    al = @@albums.find {|album| album[1].name.downcase == str.downcase}
    al[1]
  end
end

# when adding more attributes, update constructor to expect attributes hash:
# class Album
#   def initalize(attributes)
#     @name = attributes.fetch(:name)
#     @artist = attributes.fetch(:artist)
#     @year = attributes.fetch(:year)
#     @genre = attributes.fetch(:genre)
#     @length = attributes.fetch(:length)
#   end
# end