class BooksController < ApplicationController
  require 'net/http'
  require "json"
  require 'uri'

  before_action :set_api, only: [:show, :create]
  before_action :base_info, only: [:show, :create]

  def index
    search_uri = "https://www.googleapis.com/books/v1/volumes?q=#{params[:search]}&maxResults=40&orderBy=relevance"
    enc_str = URI.encode(search_uri)
    uri = URI.parse(enc_str)
    json = Net::HTTP.get(uri)
    @books = JSON.parse(json)
    @base_contents = @books["items"]
  end

  def show
    @author = @base_content["volumeInfo"]["authors"]
    @publisher = @base_content["volumeInfo"]["publisher"]
    @book_id = @base_content["id"].encode!
    @description = @base_content["volumeInfo"]["description"]
  end

  def create
    @book_fav = current_user.books.new(book_id: params[:work_id], book_name: @title, book_image_url: @img_url )
    @book_fav.save
    redirect_to book_index_user_path(current_user), notice: 'BOOK LISTの項目を追加しました'
  end

  def destroy
    @book_fav = current_user.books.find_by(book_id: params[:work_id])
    @book_fav.destroy
    redirect_to book_index_user_path(current_user), alert: 'BOOK LISTの項目を削除しました'
  end

  private 

  def set_api
    url = "https://www.googleapis.com/books/v1/volumes?q=id:#{params[:work_id]}"
    enc_str = URI.encode(url)
    uri = URI.parse(enc_str)
    json = Net::HTTP.get(uri)
    @book = JSON.parse(json)
  end

  def base_info
    @base_content = @book["items"].first
    @img_url = @base_content["volumeInfo"]["imageLinks"]["smallThumbnail"]
    @title = @base_content["volumeInfo"]["title"]
  end
end
