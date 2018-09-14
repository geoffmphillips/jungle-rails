class ReviewsController < ApplicationController

  def create
    @product = Product.where(id: params[:product_id])
    @review = @product.Review.new(review_params)

    if @review.save
      redirect_to [:admin, :products], notice: 'Product created!'
    else
      render product_path
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :description,
      :rating,
      :user_id,
    )
  end

end
