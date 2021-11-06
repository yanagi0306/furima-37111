FactoryBot.define do
  factory :order_address do

    postal_code {"336-0015"}
                municipal{Gimei.city.kanji}
                house_number{Faker::Lorem.characters}
                prefecture_id{ rand(2..48) }
                phone_number{ "0#{format("%0#{10}d", SecureRandom.random_number(10**10))}" }
                building{Faker::Lorem.characters}
                token{}
  end
end
