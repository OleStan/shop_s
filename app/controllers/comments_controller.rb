class CommentsController < ApplicationController
  before_action :find_product, only: :create
  before_action :set_comment, only: [:edit, :destroy, :update]
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

  def update
    if @comment.update(permitted_comment_params)
         redirect_to category_product_path( id: @comment.product.id, category_id: @comment.product.category_id),
                     notice: 'Comment was successfully edited.'
    else
       render :edit
    end
  end

  def destroy
    @comment.destroy
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def find_product
    @product = Product.find(params[:comment][:product_id])
  end

  def permitted_comment_params
    params.require(:comment).permit(:body, :rating)
  end

end
