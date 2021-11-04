require 'rails_helper'

RSpec.describe Item, type: :model do
  before { @item = FactoryBot.build(:item) }
  describe '商品出品' do
    context '出品できる' do
      it '正しい値が入力されている' do
        expect(@item).to be_valid
      end
    end
    context '出品できない' do
      context 'name関係' do
        it 'nameが未入力' do
          @item.name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end
        it 'nameが40文字以上' do
          @item.name = 'a' * 100
          @item.valid?

          expect(@item.errors.full_messages).to include(
            'Name is too long (maximum is 40 characters)'
          )
        end
      end
      context 'description関係' do
        it 'description未入力' do
          @item.description = ''
          @item.valid?
          expect(@item.errors.full_messages).to include(
            "Description can't be blank"
          )
        end
        it 'descriptionが１０００文字以上' do
          @item.description = 'a' * 1200
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Description is too long (maximum is 1000 characters)'
          )
        end
      end
      context 'shipping_bearer_id関係' do
        it 'shipping_bearer_idが空' do
          @item.shipping_bearer_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include(
            "Shipping bearer can't be blank"
          )
        end
        it 'shipping_bearer_idが1' do
          @item.shipping_bearer_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include(
            "Shipping bearer can't be blank",
            'Shipping bearer Please make it a positive number from 2 to 3'
          )
        end
        it 'shipping_bearer_id数字以外' do
          @item.shipping_bearer_id = 'aa'
          @item.valid?
          expect(@item.errors.full_messages).to include(
            "Shipping bearer can't be blank"
          )
        end
        it 'shipping_bearer_id少数' do
          @item.shipping_bearer_id = 3.5
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Shipping bearer Please make it a positive number from 2 to 3'
          )
        end
        it 'shipping_bearer_id負数' do
          @item.shipping_bearer_id = -2
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Shipping bearer Please make it a positive number from 2 to 3'
          )
        end
        it 'shipping_bearer_id指定のidより大きい' do
          @item.shipping_bearer_id = 100
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Shipping bearer Please make it a positive number from 2 to 3'
          )
        end
      end
      context 'status_id関係' do
        it 'status_idが空' do
          @item.status_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Status can't be blank")
        end
        it 'status_idが1' do
          @item.status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Status can't be blank")
        end
        it 'status_id数字以外' do
          @item.status_id = 'aa'
          @item.valid?

          expect(@item.errors.full_messages).to include(
            "Status can't be blank",
            'Status Please make it a positive number from 2 to 7'
          )
        end
        it 'status_id少数' do
          @item.status_id = 3.5
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Status Please make it a positive number from 2 to 7'
          )
        end
        it 'status_id負数' do
          @item.status_id = -2
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Status Please make it a positive number from 2 to 7'
          )
        end
        it 'status_id指定のidより大きい' do
          @item.status_id = 100
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Status Please make it a positive number from 2 to 7'
          )
        end
      end
      context 'shipping_day_id関係' do
        it 'shipping_day_idが空' do
          @item.shipping_day_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include(
            "Shipping day can't be blank"
          )
        end
        it 'shipping_day_id数字以外' do
          @item.shipping_day_id = 'aaa'
          @item.valid?
          expect(@item.errors.full_messages).to include(
            "Shipping day can't be blank",
            'Shipping day Please make it a positive number from 2 to 4'
          )
        end
        it 'shipping_day_id少数' do
          @item.shipping_day_id = 2.5
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Shipping day Please make it a positive number from 2 to 4'
          )
        end
        it 'shipping_day_id負数' do
          @item.shipping_day_id = -2
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Shipping day Please make it a positive number from 2 to 4'
          )
        end
        it 'shipping_day_id指定のidより大きい' do
          @item.shipping_day_id = 100
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Shipping day Please make it a positive number from 2 to 4'
          )
        end
      end
      context 'price関係' do
        it 'priceが空' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end
        it 'price数字以外' do
          @item.price = 'aaa'
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Price Please make it a positive number from 300 to 9999999'
          )
        end
        it 'price少数' do
          @item.price = 2.5
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Price Please make it a positive number from 300 to 9999999'
          )
        end
        it 'price負数' do
          @item.price = -2
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Price Please make it a positive number from 300 to 9999999'
          )
        end
        it 'price指定より大きい' do
          @item.price = 10_000_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Price Please make it a positive number from 300 to 9999999'
          )
        end
        it 'price指定より小さい' do
          @item.price = 100
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Price Please make it a positive number from 300 to 9999999'
          )
        end
      end
      context 'prefecture_id関係' do
        it 'prefecture_idが空' do
          @item.prefecture_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include(
            "Prefecture can't be blank"
          )
        end
        it 'prefecture_id数字以外' do
          @item.prefecture_id = 'aa'
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Prefecture Please make it a positive number from 2 to 48'
          )
        end
        it 'prefecture_id少数' do
          @item.prefecture_id = 2.5
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Prefecture Please make it a positive number from 2 to 48'
          )
        end
        it 'prefecture_id負数' do
          @item.prefecture_id = -2
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Prefecture Please make it a positive number from 2 to 48'
          )
        end
        it 'prefecture_id指定のidより大きい' do
          @item.prefecture_id = 100
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Prefecture Please make it a positive number from 2 to 48'
          )
        end
      end
      context 'category_name_id関係' do
        it 'category_name_idが空' do
          @item.category_name_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include(
            "Category name can't be blank",
            "Category name can't be blank"
          )
        end
        it 'category_name_id数字以外' do
          @item.category_name_id = 'aa'
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Category name Please make it a positive number from 2 to 11'
          )
        end
        it 'category_name_id少数' do
          @item.category_name_id = 2.5
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Category name Please make it a positive number from 2 to 11'
          )
        end
        it 'category_name_id負数' do
          @item.category_name_id = -2
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Category name Please make it a positive number from 2 to 11'
          )
        end
        it 'category_name_id指定のidより大きい' do
          @item.category_name_id = 100
          @item.valid?
          expect(@item.errors.full_messages).to include(
            'Category name Please make it a positive number from 2 to 11'
          )
        end
      end
      context 'image関係' do
        it 'image関係が空' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end
      end
      it 'userと紐付いていない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end
