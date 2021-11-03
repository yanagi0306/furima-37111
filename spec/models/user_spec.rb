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
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      context 'email関係' do
        it 'email未入力' do
          @user.email = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it 'email＠がない' do
          @user.email = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end
        it 'email重複している' do
          @user.save
          user1 = FactoryBot.build(:user, email: @user.email)
          user1.valid?
          expect(user1.errors.full_messages).to include(
            'Email has already been taken',
          )
        end
      end
      context 'password関係' do
        it 'password未入力' do
          @user.password = ''
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "Password can't be blank",
          )
        end
        it '英字のみのパスワードでは登録できない' do
          @user.password = 'aaaaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end
        it '数字のみのパスワードでは登録できない' do
          @user.password = '111111'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end
        it '全角文字を含むパスワードでは登録できない' do
          @user.password = 'あああああ'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end
        it 'passwordとpassword_confirmation一致しない' do
          @user.password = 'aaa111'
          @user.password_confirmation = 'bbb222'
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "Password confirmation doesn't match Password",
          )
        end
        it 'password5文字以下' do
          @user.password = 'aa111'
          @user.password_confirmation = 'aa111'
          @user.valid?
          expect(@user.errors.full_messages).to include(
            'Password is too short (minimum is 6 characters)',
          )
        end
      end
      context 'first_name関係' do
        it 'first_name未入力' do
          @user.first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "First name can't be blank",
          )
        end
        it 'first_name全角（漢字・ひらがな・カタカナ）以外入力' do
          @user.first_name = 'aaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name is invalid')
        end
      end
      context 'last_name関係' do
        it 'last_name未入力' do
          @user.last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "Last name can't be blank",
          )
        end
        it 'last_name（漢字・ひらがな・カタカナ）以外入力' do
          @user.last_name = 'aaaa'
          @user.valid?
          expect(@user.errors.full_messages).to include('Last name is invalid')
        end
      end
      context 'kana_first_name関係' do
        it 'kana_first_name未入力' do
          @user.kana_first_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "Kana first name can't be blank",
          )
        end
        it 'kana_first_name（漢字・ひらがな・カタカナ）以外入力' do
          @user.kana_first_name = 'aaa'
          @user.valid?
          expect(@user.errors.full_messages).to include(
            'Kana first name is invalid',
          )
        end
      end
      context 'kana_last_name関係' do
        it 'kana_last_name未入力' do
          @user.kana_last_name = ''
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "Kana last name can't be blank",
          )
        end
        it 'kana_last_name（漢字・ひらがな・カタカナ）以外入力' do
          @user.kana_last_name = 'aaa'
          @user.valid?
          expect(@user.errors.full_messages).to include(
            'Kana last name is invalid',
          )
        end
      end
      context 'birthday関係' do
        it 'birthday未入力' do
          @user.birthday = nil
          @user.valid?
          expect(@user.errors.full_messages).to include(
            "Birthday can't be blank",
          )
        end
      end
    end
  end
end
