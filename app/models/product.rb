class Product < ApplicationRecord
  belongs_to :category
  scope :min_price, ->(min) { where('price >= ?', min) }
  scope :max_price, ->(max) { where('price <= ?', max) }

  def product_name
    product.try(:name)
  end

  def product_name=(name)
    self.product = Product.find_by_name(name) if name.present?
  end
end
