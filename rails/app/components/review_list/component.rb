# frozen_string_literal: true

class ReviewList::Component < ViewComponent::Base
  def initialize(reviews:, review_likes:, current_user:)
    @reviews = ReviewDecorator.decorate_collection(reviews)
    @review_likes = review_likes
    @current_user = current_user
    super
  end
end
