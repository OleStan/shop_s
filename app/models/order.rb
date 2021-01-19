class Order < ApplicationRecord
  belongs_to :user

  VALID_QUANTITY = /\A\d\z/i
  validates :quantity, presence: true#, format: { with: VALID_QUANTITY }
  validates :user_id, :item, presence: true

  scope :in_process, -> { where('status = 0') }
  scope :confirmed, -> { where('status = 1') }
  scope :canceled, -> { where('status = 2') }
end
