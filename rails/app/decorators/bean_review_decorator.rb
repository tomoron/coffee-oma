class BeanReviewDecorator < ApplicationDecorator
  delegate_all

  delegate :name, to: :bean, prefix: true

  delegate :icon, to: :user, prefix: true

  def user_name
    user.username
  end

  def like_class
    'BeanReviewLike'
  end

  def base_class
    'BeanReview'
  end

  def user_icon
    user.icon.url
  end
end
