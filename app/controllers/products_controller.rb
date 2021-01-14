class ProductsController < ApplicationController
  before_action :find_category, only: [:show]
  before_action :set_product, only: [:show]

  def index; end

  def show; end

  def to_param
    name
  end
  private

  def find_category
    @category = Category.find(params[:category_id])
  end

  def set_product
    @product = @category.products.find(params[:id])
  end


  def product_params
    params.require(:product).permit(:category_id, :price, :photo, :about, :config, :article, :factory, :name)
  end


end
