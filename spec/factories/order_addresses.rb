FactoryBot.define do
  factory :order_address do
    postal_code { '336-0015' }
    municipal { '千代田区' }
    house_number { 2-3 }
    prefecture_id { 2 }
    phone_number {'08012345678'}
    building { 'コーポ' }
    token { 'tok_a7c13a5af41fa27a1c8983475086' }
  end
end
