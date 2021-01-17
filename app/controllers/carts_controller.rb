# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_user
  before_action :find_product, only: [:change_quantity]
  def index
    @items_list = @user.carts
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
    redirect_to '/carts'
  end

  def change_quantity
    case params[:argument]
    when '-'
      @item.quantity <= 1 ? @item.quantity = 0 : @item.decrement(:quantity)
    when '+'
      @item.increment(:quantity)
    end
    @item.save
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
