# frozen_string_literal: true

class BeanReviewList::Component < ViewComponent::Base
  def initialize(bean_reviews:, bean_review_likes:, current_user:)
    @bean_reviews = bean_reviews
    @bean_review_likes = bean_review_likes
    @current_user = current_user
  end
end
