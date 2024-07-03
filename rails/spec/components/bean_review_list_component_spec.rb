# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BeanReviewList, type: :component do
  let(:bean_review) { create(:bean_review, user: user) }
  let(:bean_review_like) { create(:bean_review_like, liked_id: bean_review.id, user: user) }
  let(:user) { create(:user) }

  before do
    bean_review_like
  end

  it 'renders a bean review list' do
    reviews = BeanReview.where(user: user).page(1).per(5)
    review_likes = BeanReviewLike.where(user: user).page(1).per(5)
    render_inline(BeanReviewList::Component.new(bean_reviews: reviews, bean_review_likes: review_likes, current_user: user))
    expect(page).to have_css('#bean_review_list')
  end
end
