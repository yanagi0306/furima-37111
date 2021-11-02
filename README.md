# テーブル設計

## Usersテーブル　

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null:false                |
| email              | string | null:false,unique:true    |
| encrypted_password | string | null:false                |
| first_name         | string | null:false                |
| last_name          | string | null:false                |
| kana_name          | string | null:false                |
| birthday           | date   | null:false                |

### Association

- has_many :items
- has_many :orders




## Itemsテーブル

| Colum              | Type       | Options                       |
| ------------------ | ---------- | ----------------------------- |
| name               | string     | null:false                    |
| description        | text       | null:false                    |
| status_id          | integer    | null:false                    |
| shipping_ bearer_id| integer    | null:false                    |
| day_id             | integer    | null:false                    |
| price              | integer    | null:false                    |
| area_id            | integer    | null:false                    |
| category_name_id   | integer    | null:false                    |
| user               | references | null:false,foreign_key: true  |




### Association

- belongs_to :order
- belongs_to :user





## Ordersテーブル

| Colum              | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| item               | references | null:false,foreign_key: true   |
| user               | references | null:false,foreign_key: true   |
| address            | references | null:false,foreign_key: true   |


### Association


- belongs_to :user
- has_one :item
- belongs_to :address




## Addressテーブル

| Colum              | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| postal_code        | string     | null:false                     |
| municipal          | string     | null:false                     |
| house_number       | string     | null:false                     |
| building           | string     | null:false                     |
| prefecture_id      | integer    | null:false                     |
| order              | references | null:false,foreign_key: true   |



### Association

- has_one :order
