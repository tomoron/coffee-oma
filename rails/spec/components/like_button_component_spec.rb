# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikeButton, type: :component do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:like) { create(:product_like, liked_id: product.id, user: user) }

  it 'renders a like button(unlike)' do
    render_inline(LikeButton::Component.new(like: nil, liked: product.decorate, signed_in: true))

    expect(page).to have_css('.large.heart.icon')
  end

  it 'renders a like button(like)' do
    render_inline(LikeButton::Component.new(like: like, liked: product.decorate, signed_in: true))

    expect(page).to have_css('.red.large.heart.icon')
  end
end
