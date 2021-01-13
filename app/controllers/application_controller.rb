class ApplicationController < ActionController::Base
  before_action :all_product

  include Pagy::Backend

  private
  def all_product
    @productsfor = Product.new
  end
end
