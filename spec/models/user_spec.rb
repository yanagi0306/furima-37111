require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before { @user = FactoryBot.build(:user) }

    context 'ユーザー新規登録できる' do
      it '正しい値が入力されている' do
        expect(@user).to be_valid
      end
    end
    context 'ユーザー新規登録できない' do
      it 'nickname未入力' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      context 'email関係' do
        it 'email未入力' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Eメールを入力してください")
        end
        it 'email＠がない' do
          @user.email = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('Eメールは不正な値です')
        end
        it 'email重複している' do
          @user.save
          user1 = FactoryBot.build(:user, email: @user.email)
          user1.valid?
          expect(user1.errors.full_messages).to include(
            'Eメールはすでに存在します'
          )
        end
      end
      context 'password関係' do
        it 'password未入力' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "パスワードを入力してください"
          )
        end
        it '英字のみのパスワードでは登録できない' do
          @user.password = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードは不正な値です')
        end
        it '数字のみのパスワードでは登録できない' do
          @user.password = '111111'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードは不正な値です')
        end
        it '全角文字を含むパスワードでは登録できない' do
          @user.password = 'ああああああ'
          @user.valid?
          expect(@user.errors.full_messages).to include('パスワードは不正な値です')
        end
        it 'passwordとpassword_confirmation一致しない' do
          @user.password = 'aaa111'
          @user.password_confirmation = 'bbb222'
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "パスワード（確認用）とパスワードの入力が一致しません"
          )
        end
        it 'password5文字以下' do
          @user.password = 'aa111'
          @user.password_confirmation = 'aa111'
          @user.valid?
          expect(@user.errors.full_messages).to include(
            'パスワードは6文字以上で入力してください'
          )
        end
      end
      context 'first_name関係' do
        it 'first_name未入力' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "苗字を入力してください"
          )
        end
        it 'first_name全角（漢字・ひらがな・カタカナ）以外入力' do
          @user.first_name = 'aaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('苗字は不正な値です')
        end
      end
      context 'last_name関係' do
        it 'last_name未入力' do
          @user.last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "名前を入力してください"
          )
        end
        it 'last_name（漢字・ひらがな・カタカナ）以外入力' do
          @user.last_name = 'aaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('名前は不正な値です')
        end
      end
      context 'kana_first_name関係' do
        it 'kana_first_name未入力' do
          @user.kana_first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "苗字(カナ)を入力してください"
          )
        end
        it 'kana_first_name（漢字・ひらがな・カタカナ）以外入力' do
          @user.kana_first_name = 'aaa'
          @user.valid?
          expect(@user.errors.full_messages).to include(
            '苗字(カナ)は不正な値です'
          )
        end
      end
      context 'kana_last_name関係' do
        it 'kana_last_name未入力' do
          @user.kana_last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "名前(カナ)を入力してください"
          )
        end
        it 'kana_last_name（漢字・ひらがな・カタカナ）以外入力' do
          @user.kana_last_name = 'aaa'
          @user.valid?
          expect(@user.errors.full_messages).to include(
            '名前(カナ)は不正な値です'
          )
        end
      end
      context 'birthday関係' do
        it 'birthday未入力' do
          @user.birthday = nil
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "誕生日を入力してください"
          )
        end
      end
    end
  end
end
