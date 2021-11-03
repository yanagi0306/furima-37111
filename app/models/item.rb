class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :status
  belongs_to :shipping_bearer
  belongs_to :shipping_day
  belongs_to :category_name
  has_one_attached :image
  belongs_to :user


  validates :name,length: {maximum:40},presence: true

  validates :description,length: {maximum:1000},presence: true

  validates :status_id,numericality: { only_integer: true,greater_than_or_equal_to: 2, less_than_or_equal_to: 1000 },numericality: { other_than: 1 , message: "can't be blank"}

  validates :shipping_bearer_id,numericality: { only_integer: true,greater_than_or_equal_to: 2, less_than_or_equal_to: 3 },numericality: { other_than: 1 , message: "can't be blank"}

  validates :shipping_day_id,numericality: { only_integer: true,greater_than_or_equal_to: 2, less_than_or_equal_to: 4 },numericality: { other_than: 1 , message: "can't be blank"}

  validates :prefecture_id, numericality: { only_integer: true,greater_than_or_equal_to: 2, less_than_or_equal_to: 48 },numericality: { other_than: 1 , message: "can't be blank"}

  validates :category_name_id, numericality: { only_integer: true,greater_than_or_equal_to: 2, less_than_or_equal_to: 11 },numericality: { other_than: 1 , message: "can't be blank"}


  validates :price, numericality: { only_integer: true,greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

  validates :image,presence: true
end
