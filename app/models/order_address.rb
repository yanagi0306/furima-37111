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
            :phone_number,
            presence: true

  validates :item_id,:user_id,presence:{message:'が紐付いていません'}
  validates :postal_code,
            format: {
              with: /\A[0-9]{3}-[0-9]{4}\z/,
              message: 'の入力は-をつけてください(入力は半角でお願いします)'
            },
            allow_blank: true
  validates :phone_number,
            format: {
              with: /\A\d{10,11}\z/,
              message: 'の入力が無効です(入力は半角でお願いします)'
            },
            allow_blank: true

  validates :prefecture_id,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 2,
              less_than_or_equal_to: 48,
              message: 'を選択してください'
            }

  validates :token,
            presence: {
              message: 'の入力が無効です'
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
      order_id: order.id
    )
  end
end
