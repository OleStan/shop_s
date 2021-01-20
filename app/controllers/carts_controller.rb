# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_user
  before_action :find_product, only: [:change_quantity]
  def index
    @pagy, @items_list = pagy(@user.carts, items: 5)
  end

  def add
    cart_params = permitted_cart_params.merge(user_id: @user.id)
    @product = Cart.find_by(cart_params.except(:quantity))
    if @product.present?
      @product.increment(:quantity)
      @product.save
    else
      Cart.create(cart_params)
    end
    render 'carts/cart_add', product: @product
  end

  def destroy
    @cart = @user.carts.find(params[:id])
    @cart_id = @cart.id
    render 'carts/cart_destroy'
    @cart.destroy


  end

  def change_quantity
    case params[:argument]
    when '-'
      @item.quantity <= 1 ? @item.quantity = 1 : @item.decrement(:quantity)
    when '+'
      @item.increment(:quantity)
    end
    @item.save
    @price = Product.find(@item.id).price * @item.quantity
    render 'carts/quantity'
  end

  private

  def set_user
    @user = current_user
  end

  def permitted_cart_params
    params.permit(:item, :quantity)
  end

  def find_product
    @item = Cart.find(params[:id])
  end
end
