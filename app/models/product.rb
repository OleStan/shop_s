class Product < ApplicationRecord
  belongs_to :category
  has_one_attached :photo
  has_many :comments, dependent: :destroy

  scope :min_price, ->(min) { where('price >= ?', min) }
  scope :max_price, ->(max) { where('price <= ?', max) }

  def rating
    return 'no rating at the moment' if comments.empty?
    return (comments.sum(&:rating).to_f / comments.count).round(1) if comments.present?
  end

  def product_name
    product.try(:name)
  end

  def product_name=(name)
    self.product = Product.find_by_name(name) if name.present?
  end
end
