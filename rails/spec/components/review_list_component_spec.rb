# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewList, type: :component do
  let(:user) { create(:user) }
  let(:review) { create(:review, user: user) }
  let(:review_like) { create(:product_review_like, liked_id: review.id, user: user) }

  it 'renders a list of reviews' do
    review_like
    reviews = Review.show_review(review.product).page(1).per(5)
    review_likes = user.where_review_likes(reviews, 'review')
    render_inline(ReviewList::Component.new(reviews: reviews, review_likes: review_likes, current_user: user))

    expect(page).to have_css('.review_item')
  end

  # it 'when not a review rendersa list of reviews' do
  #   render_inline(ReviewList::Component.new(reviews: [], review_likes: nil, current_user: user))

  #   expect(page).to have_text('このアイテムに寄せられたレビューはまだありません。')
  # end
end
