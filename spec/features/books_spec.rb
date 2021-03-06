# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Books', type: :feature do
  scenario 'user search books and creates a new book favorite' do
    user = create(:user)
    sign_in user
    visit root_path
    expect do
      within '.book-fav-btns' do
        click_link('追加する')
      end

      fill_in 'search-form-id', with: '村上春樹'
      click_button '検索'

      expect(page).to have_content('村上春樹の検索結果')
      first('.list-btns').click_link('詳細')
      expect(page).to have_content('著者')
      click_link('リストに追加する')
    end.to change(user.books, :count).by(1)
  end
end
