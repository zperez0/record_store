require('spec_helper')

describe('Artist') do

  # before(:each) do
  #   Album.clear
  #   Song.clear
  #   Artist.clear
  # end

    describe('.all') do
      it('returns an empty array when there are no artists') do
        expect(Artist.all).to(eq([]))
      end
    end

    describe('#save') do
      it("saves an artist") do
        artist = Artist.new({:name => "cheese boi", :id => nil})
        artist.save()
        artist2 = Artist.new({:name => "big mac", :id => nil})
        artist2.save()
        expect(Artist.all).to(eq([artist, artist2]))
      end
    end

    describe('#==') do
      it("is the same artist if it has the same attributes as another artist") do
        artist = Artist.new({:name => "cheese boi", :id => nil})
        artist2 = Artist.new({:name => "big mac", :id => nil})
        expect(artist).to(eq(artist))
      end
    end


    describe('.clear') do
      it("clears all artists") do
        artist = Artist.new({:name => "cheese boi", :id => nil})
        artist.save()
        artist2 = Artist.new({:name => "big mac", :id => nil})
        artist2.save()
        Artist.clear()
        expect(Artist.all).to(eq([]))
      end
    end
  end
