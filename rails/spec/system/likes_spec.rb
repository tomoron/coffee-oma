require 'rails_helper'

RSpec.describe 'Likes', type: :system, js: true do
  let(:user) { create(:user) }
  let(:user1) { create(:user, username: 'test1', email: 'test1@example.com') }
  let(:product) { create(:product,user: user) }
  let(:product1) { create(:product, itemname: 'コーヒー豆の種類', likes_count: 2,user: user) }
  let(:bean) { create(:bean, user: user) }
  let(:product_like) { create(:like, user: user, liked_id: product.id, type: 'ProductLike') }
  let(:bean_like) { create(:like, user: user, liked_id: bean.id, type: 'BeanLike') }

  describe 'index' do
    before do
      product
      product1
      visit likes_path
    end

    it 'render product' do
      expect(page).to have_link nil, href: product_path(product.id)
      expect(page).to have_link nil, href: product_path(product1.id)
    end

    it 'render ranking' do
      sleep 1
      first('div.ui.three.stackable.cards.segment.mt-3rem a').click
      expect(page).to have_current_path product_path(product1.id)
    end
  end

  describe 'create' do
    context 'when login' do
      before do
        login(user, user.email, user.password)
      end

      it 'click like button(product)' do
        visit product_path(product.id)
        click_on 'お気に入り登録'
        expect(page).to have_link 'お気に入り登録中'
      end

      it 'click like button(bean)' do
        visit bean_path(bean.id)
        click_on 'お気に入り登録'
        expect(page).to have_link 'お気に入り登録中'
      end
    end

    context 'when not login' do
      it 'not render like button' do
        visit product_path(product.id)
        expect(page).to have_no_link 'お気に入り登録'
      end
    end
  end

  describe 'destroy' do
    context 'when login' do
      before do
        login(user, user.email, user.password)
        product_like
        bean_like
      end

      it 'click like destroy button(product)' do
        visit product_path(product.id)
        click_on 'お気に入り登録中'
        expect(page).to have_link 'お気に入り登録'
      end

      it 'click like destroy button(bean)' do
        visit bean_path(bean.id)
        click_on 'お気に入り登録'
        expect(page).to have_link 'お気に入り登録'
      end
    end

    context 'when not login' do
      before do
        product_like
        visit product_path(product.id)
      end

      it 'not render button' do
        expect(page).to have_no_link 'お気に入り登録中'
      end
    end
  end
end
