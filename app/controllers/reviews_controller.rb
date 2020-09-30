class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    review = current_user.reviews.new(review_params)
    if review.save
      redirect_to product_path(review.product_id), notice: 'レビューを登録しました'
    else
      flash[:alert] = 'レビューが登録に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def index; end

  private
    def review_params
      params.require(:review).permit(:title, :rate, :content, :product_id)
    end
end
