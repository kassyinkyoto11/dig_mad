# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  it 'is valid with user_id and movie_id' do
    movie = build_stubbed(:movie)
    expect(movie).to be_valid
  end

  it 'is invalid without movie_id' do
    movie = build_stubbed(:movie, movie_id: nil)
    movie.valid?
    expect(movie).to be_invalid
  end

  it 'is invalid without user_id' do
    movie = build_stubbed(:movie, user_id: nil)
    movie.valid?
    expect(movie).to be_invalid
  end

  it 'is invalid with duplicate artist_id by same user' do
    user = create(:user)
    create(:movie, movie_id: '24ce8dbd-ce7d-4352-ad3f-7dff62fbf5a9', user: user)
    movie2 = build(:movie, movie_id: '24ce8dbd-ce7d-4352-ad3f-7dff62fbf5a9', user: user)
    movie2.valid?
    expect(movie2).to be_invalid
  end
end
