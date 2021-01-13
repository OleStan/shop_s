# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def index
    # @categories = Category.all
    @categories = Category.order(:name).where('name like ?', "%#{params[:term]}%")
    render json: @categories.map(&:name)
  end

  def new
    @category = Category.new
  end

  def show
    # @category.save
    # @products = if sort_column && sort_direction
    # Product.order("#{sort_column} #{sort_direction}")
    # else
    # Product.all
    # end
    @products = if params[:min].nil? && params[:max].nil?
                  (sort_column && sort_direction) ? Product.order("#{sort_column} #{sort_direction}") : Product.all
                else
                  if !(sort_column && sort_direction)
                    Product.min_price(minimum).max_price(maximum).order(sort_column.to_s)
                  else Product.min_price(minimum).max_price(maximum).order("#{sort_column} #{sort_direction}")
                  end
                end
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

  def range
    @products = Product.min_price(params[:min]).max_price(params[:max])
    @category = Category.find(params[:id])
    render 'categories/show'
  end

  def to_param
    return nil unless persisted?

    [id, slug].join('-')
  end

  private

  def sort_column
    Product.column_names.include?(params[:sort]) ? params[:sort] : nil
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : nil
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def minimum
    params[:min].nil? ? 0 : params[:min]
  end

  def maximum
    params[:max].nil? ? 99_999_999_999 : params[:max]
  end

  def category_params
    params.require(:category).permit(:name, :parent_id, :image)
  end
end
