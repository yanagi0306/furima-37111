# テーブル設計

## Usersテーブル　

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null:false  |
| email              | string | null:false  |
| encrypted_password | string | null:false  |
| full_name          | string | null:false  |
| kana_name          | string | null:false  |
| birthday           | date   | null:false  |

### Association

- has_many : items
- has_many : orders



## Itemsテーブル

| Colum              | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| name               | string     | null:false                    |
| description        | text       | null:false                    |
| status             | string     | null:false                    |
| shipping_area      | string     | null:false                    |
| shipping_data      | string     | null:false                    |
| cost               | string     | null:false                    |
| user_id            | references | null:false,foreign_key: true  |


### Association

- belongs_to :order
- belongs_to :user
- belongs_to :category
- belongs_to :area





## Ordersテーブル

| Colum              | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item_id            | references | null:false,foreign_key: true   |
| address_id         | references | null:false,foreign_key: true   |
| user_id            | references | null:false,foreign_key: true   |


### Association

- has_one :item
- belongs_to :user
- belongs_to :address
- belongs_to :credit




## Categoryesテーブル

| Colum              | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| category_name      | string     | null:false                     |
| item_id            | references | null:false,foreign_key: true   |

### Association

- has_one :item




## Creditsテーブル

| Colum              | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| credit_card_date   | string     | null:false                     |
| order_id           | references | null:false,foreign_key: true   |


### Association

- has_one :order




## Addressテーブル

| Colum              | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postal_code        | string     | null:false                     |
| municipal          | string     | null:false                     |
| house_number       | string     | null:false                     |
| building           | string     | null:false                     |
| order_id           | references | null:false,foreign_key: true   |
| prefectures_id     | references | null:false,foreign_key: true   |


### Association

- has_one :order
- belongs_to :prefectures




## Prefecturesテーブル

| Colum              | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| prefecture_name    | string     | null:false                     |
| addres_id          | references | null:false,foreign_key: true   |


### Association

- has_one :address



## Areaテーブル

| Colum              | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| shipping_area      | string     | null:false                     |
| item_id            | references | null:false,foreign_key: true   |


### Association

- has_one :item
