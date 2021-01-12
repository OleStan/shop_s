class ProductsController < ApplicationController
  before_action :find_category, only: [:show]
  before_action :set_product, only: [:show]

  def index

  end

  def new
    #@category = @post.comments.create(comment_params)
  end

  def edit
    #@comment = Comment.find(params[:id])
    #render 'comments/update_comment'
  end

  def show

  end

  def create
    #@comment = @post.comments.create(comment_params)

    #render 'comments/post_comment' #or redirect_to post_path(@post)
  end

  def destroy
    #@comment = @post.comments.find(params[:id])
    #@comment_id = @comment.id
    #render 'comments/destroy_comment'
    #@comment.destroy

  end

  def update
    #@comment = @post.comments.find(params[:id])
    #@comment.published!
    #@comment.update(comment_params)
    #redirect_to post_path(@post)
  end

  private

  def find_category
    @category = Category.find(params[:category_id])
  end

  def set_product
    @product = @category.products.find(params[:id])
  end


  def product_params
    params.require(:product).permit(:category_id, :price, :photo, :about, :config, :article, :factory, :product_name)
  end


end
