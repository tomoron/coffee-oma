# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewsUserShow, type: :component do
  let(:review) { create(:review) }

  it 'renders a list of reviews' do
    reviews = Review.user_review(review.user)
    render_inline(ReviewsUserShow::Component.new(reviews: reviews))
    expect(page).to have_text(review.product.name)
  end

  it 'when not review renders a list of reviews' do
    render_inline(ReviewsUserShow::Component.new(reviews: []))
    expect(page).to have_text('まだ投稿はありません')
  end
end
