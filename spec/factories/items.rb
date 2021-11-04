FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    status_id { rand(2..7) }
    shipping_bearer_id { rand(2..3) }
    shipping_day_id { rand(2..4) }
    price { rand(300..9_999_999) }
    prefecture_id { rand(2..48) }
    category_name_id { rand(2..11) }
    association :user

    after(:build) do |item|
      item.image.attach(
        io: File.open('app/assets/images/item-sample.png'),
        filename: 'item-sample.png'
      )
    end
  end
end
