class Album
  attr_reader :id
  attr_accessor :name
  

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all()
    returned_albums = DB.exec("SELECT * FROM albums;")
    albums =[]
    returned_albums.each() do |album|
      name = album.fetch("name")
      id = album.fetch("id").to_i
      albums.push(Album.new({:name => name, :id => id}))
    end
    albums
  end

  def save()
    result = DB.exec("INSERT INTO albums (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.clear()
   DB.exec("DELETE FROM albums *;")
  end

  def self.find(id)
    album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
    name = album.fetch("name")
    id = album.fetch("id").to_i
    Album.new({:name => name, :id => id})
  end

  def update(name)
    @name = name
    DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete()
    DB.exec("DELETE FROM albums WHERE id = #{@id};")
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