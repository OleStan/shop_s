class OrdersController < ApplicationController
 VALID_EMAIL_REGX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_action :set_user
  before_action :authenticate_user!
 #before_action :valid_email

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
        OrdersMailer.with(user: @user, product: @product).complete_order.deliver_now
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

  def valid_email
    if @user.email.match(VALID_EMAIL_REGX).nil?

    end
    render 'valid_email'
  end

  def permitted_order_params
    params.require(:order).permit(:item, :quantity)
  end

end
