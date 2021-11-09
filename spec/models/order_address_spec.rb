require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address =
      FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  context '内容に問題なし' do
    it 'すべての情報があれば登録できる' do
      expect(@order_address).to be_valid
    end
    it 'buildingが空でも登録できる' do
      @order_address.building = ''
      expect(@order_address).to be_valid
    end
  end

  context '内容に問題あり' do
    context 'postal_code関係' do
      it 'postal_codeが空だと入力できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'postal_codeが-(ハイフン)がない' do
        @order_address.postal_code = '3360001'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号の入力は-をつけてください(入力は半角でお願いします)')
      end
      it 'postal_code 数字3桁 - 数字4桁 以外登録できない' do
        @order_address.postal_code = '336-0015555'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号の入力は-をつけてください(入力は半角でお願いします)')
      end
      it 'postal_code全角だとだめ' do
        @order_address.postal_code = '３３６-００１５'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号の入力は-をつけてください(入力は半角でお願いします)')
      end
    end
    context 'municipal関係' do
      it 'municipalが空だと入力できない' do
        @order_address.municipal = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市町村を入力してください")
      end
    end
    context 'prefecture_id関係' do
      it 'prefecture_idが空' do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include(
          "都道府県を選択してください"
        )
      end
      it 'prefecture_id数字以外' do
        @order_address.prefecture_id = 'aa'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include(
          '都道府県を選択してください'
        )
      end
      it 'prefecture_id少数' do
        @order_address.prefecture_id = 2.5
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include(
          '都道府県を選択してください'
        )
      end
      it 'prefecture_id負数' do
        @order_address.prefecture_id = -2
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include(
          '都道府県を選択してください'
        )
      end
      it 'prefecture_id指定のidより大きい' do
        @order_address.prefecture_id = 100
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include(
          '都道府県を選択してください'
        )
      end
    end
    context 'phone_number関係' do
      it 'phone_numberが空だと入力できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'phone_numberが12桁以上の場合登録できない。' do
        @order_address.phone_number = '0701234567890'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号の入力が無効です(入力は半角でお願いします)')
      end
      it 'phone_numberが9桁以下の場合登録できない。' do
        @order_address.phone_number = '0701234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号の入力が無効です(入力は半角でお願いします)')
      end
      it 'phone_numberが全角だとだめ' do
        @order_address.phone_number = '０９０００１００１５５'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('電話番号の入力が無効です(入力は半角でお願いします)')
      end
    end
    it 'userが紐付いていないと保存できないこと' do
      @order_address.user_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("購入者が紐付いていません")
    end
    it 'itemが紐付いていないと保存できないこと' do
      @order_address.item_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("商品が紐付いていません")
    end
    it 'tokenが空では登録できないこと' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('クレジットカード情報の入力が無効です')
    end
  end
end
