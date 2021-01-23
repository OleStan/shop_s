class CommentsController < ApplicationController
  before_action :find_product, only: :create

  def new
    @comment = Comment.new(product_id: params[:product_id])
  end

  def create

    comment_params = permitted_comment_params.merge(user_id: current_user.id)
    @comment = @product.comments.create(comment_params)
    if @comment.save
      redirect_to category_product_path( id: @comment.product.id, category_id: @comment.product.category_id)
    else
       render :new
    end
  end

  def edit; end

  def update; end

  private

  def find_product
    @product = Product.find(params[:comment][:product_id])
  end

  def permitted_comment_params
    params.require(:comment).permit(:body, :rating)
  end

end
