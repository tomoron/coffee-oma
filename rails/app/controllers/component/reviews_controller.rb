class Component::ReviewsController < Component::ApplicationController
  def home
    @reviews = Review.latest_review

    render turbo_stream: turbo_stream_component_replace('home_reviews', reviews: @reviews)
  end

  def list
    @reviews = Review.show_review(params[:product_id]).page(params[:page]).per(5)
    if user_signed_in?
      @reviews = Review.exclude_reviews(params[:product_id], current_user.id).page(params[:page]).per(5)
      @review_likes = current_user.where_review_likes(@reviews, 'review')
    end

    render turbo_stream: turbo_stream_component_replace('review_list', reviews: @reviews, review_likes: @review_likes, current_user: current_user)
  end

  def user_show
    @user = User.find_by(id: params[:user_id])
    @reviews = Review.user_review(@user)

    render turbo_stream: turbo_stream_component_replace('reviews_user_show', reviews: @reviews)
  end
end
