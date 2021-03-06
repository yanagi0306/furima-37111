class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items
  has_many :orders

  validates :nickname,:birthday,:first_name, :last_name,:kana_first_name, :kana_last_name, presence: true
  validates :first_name, :last_name,  format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ }, allow_blank: true
  validates :kana_first_name, :kana_last_name, format: { with: /\A[ァ-ヶー]+\z/ }, allow_blank: true
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/i }, allow_blank: true
end
