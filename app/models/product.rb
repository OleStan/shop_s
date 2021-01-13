class Product < ApplicationRecord
  belongs_to :category
  scope :min_price, ->(min) { where('price >= ?', min) }
  scope :max_price, ->(max) { where('price <= ?', max) }
  def category_name
    category.try(:name)
  end

  def category_name=(name)
    self.category = Category.find_or_create_by_name(name) if name.present?
  end
end
