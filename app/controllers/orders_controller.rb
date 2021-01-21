class OrdersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def index
    @pagy, @orders = pagy(@user.orders, items: 5)
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

  private

  def set_user
    @user = current_user
  end

  def permitted_order_params
    params.require(:order).permit(:item, :quantity)
  end

end
