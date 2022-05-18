require 'rails_helper'

RSpec.describe 'Admin product', type: :system do
  let(:admin) { create(:admin_user) }
  let(:user) { create(:user) }
  let(:product) { create(:product, user: user) }
  let(:product_like) { create(:like, user: user, liked_id: product.id, type: 'ProductLike') }
  let(:review) { create(:review, user: user, product: product) }

  describe 'product' do
    before do
      admin_login(admin)
      review
      product_like
      visit admin_products_path
    end

    it 'displayed index' do
      expect(page).to have_content '商品'
    end

    it 'created product' do
      expect do
        visit new_admin_product_path
        fill_in 'product_itemname', with: 'test_product'
        fill_in 'product_itemprice', with: '100'
        fill_in 'product_shopname', with: 'test_shop'
        fill_in 'product_itemurl', with: 'https://example.com'
        fill_in 'product_itemcaption', with: 'test_caption'
        fill_in 'product_user_id', with: user.id
        click_on '商品を作成'
      end.to change(Product, :count).by(1)
    end

    it 'displayed show' do
      visit admin_product_path(product.id)
      expect(page).to have_content product.itemname
    end

    it 'delete resource' do
      expect do
        visit admin_product_path(product.id)
        click_on '商品 を削除する'
      end.to change(Product, :count).by(-1)
    end
  end
end
