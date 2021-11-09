class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :status
  belongs_to :shipping_bearer
  belongs_to :shipping_day
  belongs_to :category_name
  has_one_attached :image
  belongs_to :user
  has_one :order

  validates :price, :name, :description, :image, presence: true

  validates :status_id,
            :shipping_bearer_id,
            :shipping_day_id,
            :prefecture_id,
            :category_name_id,
            presence: {
              message: 'の選択がされていません',
            }
  validates :user_id, presence: { message: 'が紐付いていません' }

  validates :name, length: { maximum: 40 }, allow_blank: true

  validates :description, length: { maximum: 1000 }, allow_blank: true

  validates :status_id,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 2,
              less_than_or_equal_to: 7,
              message: 'の選択がされていません',
            },
            allow_blank: true

  validates :shipping_bearer_id,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 2,
              less_than_or_equal_to: 3,
              message: 'の選択がされていません',
            },
            allow_blank: true

  validates :shipping_day_id,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 2,
              less_than_or_equal_to: 4,
              message: 'の選択がされていません',
            },
            allow_blank: true

  validates :prefecture_id,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 2,
              less_than_or_equal_to: 48,
              message: 'の選択がされていません',
            },
            allow_blank: true

  validates :category_name_id,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 2,
              less_than_or_equal_to: 11,
              message: 'の選択がされていません',
            },
            allow_blank: true

  validates :price,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999,
              message: 'は300から9999999の整数値を入力してください',
            },
            allow_blank: true
end
