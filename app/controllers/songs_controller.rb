require 'rack-flash'
class SongsController < ApplicationController
    use Rack::Flash

    
get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
end

get '/songs/new' do
    @songs = Song.all
    # binding.pry
    erb :'/songs/new'
end

get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    # binding.pry
    erb :'/songs/show'
end

get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
end

post '/songs' do
    @song = Song.create(params[:song])
    # binding.pry
    @song.artist = Artist.find_or_create_by(params[:artist])
    @song.genre_ids = params[:genres]
    @song.save
    flash[:message] = "Successfully created song."
  redirect to("/songs/#{@song.slug}")
end

patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    # @song.artist.update(params[:artist])
    # binding.pry
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])

    @song.genre_ids = params[:genres]
    @song.save

#     let(:artist_name) { "Person with a Face" }
#   let(:genre_1_name) { "Hippity Hop" }
#   let(:genre_2_name) { "New Age Garbage" }
#   let(:song_name) { "That One with the Guitar" }

    flash[:message] = "Successfully updated song."
    redirect to("/songs/#{@song.slug}")
end

# patch '/figures/:id' do
#     @figure = Figure.find(params[:id])
# # binding.pry
#     @figure.update(params["figure"])
#     # binding.pry
#     if !params["title"]["name"].empty?
#       @figure.titles << Title.create(params["title"])
#     end

#     if !params["landmark"]["name"].empty?
#       @figure.landmarks << Landmark.create(params["landmark"])
#     end
#     @figure.save
#     redirect "figures/#{@figure.id}"
# end


end
