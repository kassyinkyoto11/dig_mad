class MusicsController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :search_param, only: :index

  include ApplicationHelper

  def search; end

  def index
    @artists = search_artist(search_param['search']) unless search_param['search'].blank?
    @base_contents = @artists
  end

  def show
    @artist = find_artist(params[:work_id])
    @albums = @artist.albums
    @top_tracks = @artist.top_tracks(:US).first(3)
    @title = @artist.name
    @genres = @artist.genres
    @spotify_link = @artist.external_urls["spotify"]
    @img_url = @artist.images[1]["url"] unless @artist.images.blank?
  end

  def create
    @artist_fav = current_user.musics.new(artist_id: params[:work_id])
    @artist_fav.save
    redirect_to music_index_user_path(current_user), notice: 'ARTIST LISTの項目を追加しました'
  end

  def destroy
    @artist_fav = current_user.musics.find_by(artist_id: params[:work_id])
    @artist_fav.destroy
    redirect_to music_index_user_path(current_user), alert: 'ARTIST LISTの項目を削除しました'
  end
end
