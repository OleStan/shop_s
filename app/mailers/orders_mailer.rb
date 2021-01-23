class OrdersMailer < ApplicationMailer
  default from: 'shop-s@example.com'

  def complete_order
    @user = params[:user]
    @product = params[:product]
    mail(to: @user.email, subject: 'Order Complete')
  end
end
