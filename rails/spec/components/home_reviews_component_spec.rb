# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeReviews, type: :component do
  let(:review) { create(:review) }

  before do
    review
  end

  it 'renders a list of reviews' do
    reviews = Review.latest_review
    render_inline(HomeReviews::Component.new(reviews: reviews))
    expect(page).to have_content(review.title)
  end
end
