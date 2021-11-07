class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code,
                :municipal,
                :house_number,
                :prefecture_id,
                :phone_number,
                :building,
                :item_id,
                :user_id,
                :token

  validates :postal_code,
            :municipal,
            :house_number,
            :prefecture_id,
            :phone_number,
            :item_id,
            :user_id,
            presence: true
  validates :postal_code,
            format: {
              with: /\A[0-9]{3}-[0-9]{4}\z/,
              message: 'is invalid. Include hyphen(-)',
            },
            allow_blank: true
  validates :phone_number,
            format: {
              with: /\A\d{10,11}\z/,
              message: 'is invalid. Include hyphen(-)',
            },
            allow_blank: true

  validates :prefecture_id,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 2,
              less_than_or_equal_to: 48,
              message: 'Please make it a positive number from 2 to 48',
            },
            allow_blank: true
  validates :prefecture_id,
            numericality: {
              other_than: 1,
              message: "can't be blank",
            },
            allow_blank: true
  validates :token,
            presence: {
              message: 'is missing.Your credit card information is invalid',
            }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(
      postal_code: postal_code,
      municipal: municipal,
      house_number: house_number,
      prefecture_id: prefecture_id,
      phone_number: phone_number,
      building: building,
      order_id: order.id,
    )
  end
end
