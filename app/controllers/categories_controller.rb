class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    #@category.save
  end

  def create

    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end
  def search
    @category = category.where('content LIKE ?', "%#{params[:q]}%")
    render :index
  end
  # DELETE /categorys/1
  # DELETE /categorys/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categorys_url, notice: 'category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def to_param
    return nil unless persisted?
    [id, slug].join('-')
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end


  def category_params
    params.require(:category).permit(:category, :parent_id, :image)
  end
end
