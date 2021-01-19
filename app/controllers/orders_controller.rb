class OrdersController < ApplicationController
  before_action :set_user

  def index
    @orders = @user.orders
  end

  def new
    @order = Order.new
    @product = Product.find(params[:product])
  end
  
  def create
    @product = Product.find(params[:order][:item])
    order_params = permitted_order_params.merge(user_id: @user.id)
    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to order_index_url, notice: 'order was successfully created.' }

      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_order
    order_params = permitted_order_params.merge(user_id: @user.id)
    Order.create(order_params)
    render 'orders/buy_now'
  end

  private

  def set_user
    @user = current_user
  end

  def permitted_order_params
    params.require(:order).permit(:item, :quantity)
  end

end
