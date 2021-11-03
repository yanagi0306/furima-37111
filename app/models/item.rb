class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to: :prefecture
  belongs_to: :status
  belongs_to: :shipping_bearer
  belongs_to: :shipping_day
  belongs_to: :category_name


  validates :name,:description,presence: true

  validates :status_id,numericality: { only_integer: true,greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  validates :shipping_bearer_id,numericality: { only_integer: true,greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  validates :shipping_day_id,numericality: { only_integer: true,greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  validates :prefecture_id, numericality: { only_integer: true,greater_than_or_equal_to: 2, less_than_or_equal_to: 48 }

  validates :category_name_id, numericality: { only_integer: true,greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }


  validates :price, numericality: { only_integer: true,greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

end
