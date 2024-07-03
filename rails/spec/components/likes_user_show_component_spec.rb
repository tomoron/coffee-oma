# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesUserShow, type: :component do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:like) { create(:product_like, liked_id: product.id, user: user) }

  it 'renders a list of likes' do
    like
    likes = Like.find_product_and_bean(user)
    render_inline(LikesUserShow::Component.new(likes: likes))
    expect(page).to have_content(product.name)
  end

  it 'not render' do
    render_inline(LikesUserShow::Component.new(likes: []))
    expect(page).to have_content('まだお気に入りはありません')
  end
end
