class BeanReviewsController < ApplicationController
  def create
    @bean_review = current_user.create_bean_review(bean_review_params)
    @recipe = @bean_review.build_recipe(recipe_params)
    if @recipe.save
      flash[:notice] = '登録に成功しました'
    elsif @bean_review.save
      flash[:notice] = 'レビューの登録に成功しました。レシピの登録に失敗しました'
    else
      flash[:alert] = 'レビューの登録に失敗しました'
    end
    redirect_to bean_path(@bean_review.bean_id)
  end

  private

    def bean_review_params
      params.require(:bean_review).permit(:acidity, :bitter, :content, :flavor, :rich, :sweet, :title).merge(bean_id: params[:bean_id])
    end

    def recipe_params
      params.require(:bean_review).permit(:powdergram, :grinding, :temperature, :time, :amount, :time1, :time2)
    end
end