class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.order(name: :desc).all
  end

  def new
    @categories = Category.new
  end

  def create
    @categories = Category.new(product_params)

    if @categories.save
      redirect_to [:admin, :products], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :quantity,
      :image,
      :price
    )
  end

end
