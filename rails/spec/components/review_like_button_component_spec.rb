# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewLikeButton, type: :component do
  let(:user) { create(:user) }
  let(:review) { create(:review) }
  let(:review_like) { create(:product_review_like, liked_id: review.id, user: user) }

  it 'renders the component(like)' do
    render_inline(ReviewLikeButton::Component.new(review: review, review_like: review_like))

    expect(page).to have_css('.destroy_button')
  end

  it 'renders the component(unlike)' do
    render_inline(ReviewLikeButton::Component.new(review: review.decorate, review_like: nil))
    expect(page).to have_css('.create_button')
  end
end
