# frozen_string_literal: true

class HomeReviews::Component < ViewComponent::Base
  def initialize(reviews:)
    @reviews = ReviewDecorator.decorate_collection(reviews)
    super
  end
end
