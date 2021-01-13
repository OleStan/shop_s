class PagesController < ApplicationController

  def index
    @pagy, @categories = pagy(Category.all)
    @categories_list = Category.all

  end

  def admin
    @pagy, @categories = pagy(Category.all)
    @products = Product.all
  end

end
