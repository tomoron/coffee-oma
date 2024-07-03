class Component::BeanReviewsController < Component::ApplicationController
  def list
    @bean_reviews = BeanReview.show_review(params[:bean_id]).page(params[:page]).per(5)
    if user_signed_in?
      @bean_reviews = BeanReview.exclude_reviews(params[:bean_id], current_user.id).page(params[:page]).per(5)
      @review_likes = current_user.where_review_likes(@bean_reviews, 'bean_review')
    end

    render turbo_stream: turbo_stream_component_replace('bean_review_list', bean_reviews: @bean_reviews, bean_review_likes: @review_likes,
                                                                            current_user: current_user)
  end
end
