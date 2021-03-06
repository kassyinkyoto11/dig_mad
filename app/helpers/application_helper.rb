# frozen_string_literal: true

module ApplicationHelper
  def search_artist(artist_name)
    RSpotify::Artist.search(artist_name, limit: 50, offset: 0, market: nil)
  end

  def find_artist(artist_id)
    RSpotify::Artist.find(artist_id)
  end

  # def default_meta_tags
  #   {
  #     site: 'FAVO',
  #     title: 'FAVO',
  #     description: 'FAVOは映画・音楽・書籍のお気に入りリストを作成できるサイトです。TwitterやFacebookなどのSNSであなたのお気に入りリストを共有して趣味をアピールしたり、友達のお気に入りリストを覗いて新たな作品に出会うこともできます。',
  #     charset: 'utf-8',
  #     reverse: true,
  #     icon: image_url('favo_logo.png'),
  #     noindex: ! Rails.env.production?,
  #     separator: '|'
  #   }
  # end
end
