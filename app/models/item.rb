class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :status
  belongs_to :shipping_bearer
  belongs_to :shipping_day
  belongs_to :category_name
  has_one_attached :image
  belongs_to :user

  validates :status_id, :shipping_bearer_id, :shipping_day_id, :price, :prefecture_id, :category_name_id, :name, :description, :image,
            presence: true

  validates :status_id, :shipping_bearer_id, :shipping_day_id, :prefecture_id, :category_name_id,
            numericality: { other_than: 1, message: "can't be blank" }, allow_blank: true

  validates :name, length: { maximum: 40 }, allow_blank: true

  validates :description, length: { maximum: 1000 }, allow_blank: true

  validates :status_id,
            numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 7, message: 'Please make it a positive number from 2 to 7' }, allow_blank: true

  validates :shipping_bearer_id,
            numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 3, message: 'Please make it a positive number from 2 to 3' }, allow_blank: true

  validates :shipping_day_id,
            numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 4, message: 'Please make it a positive number from 2 to 4' }, allow_blank: true

  validates :prefecture_id,
            numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 48, message: 'Please make it a positive number from 2 to 48' }, allow_blank: true

  validates :category_name_id,
            numericality: { only_integer: true, greater_than_or_equal_to: 2, less_than_or_equal_to: 11, message: 'Please make it a positive number from 2 to 11' }, allow_blank: true

  validates :price,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'Please make it a positive number from 300 to 9999999' }, allow_blank: true
end
